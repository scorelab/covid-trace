import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository.dart';
import 'package:slcovid_tracker/data/local/dao/location_dto.dart';
import 'package:slcovid_tracker/data/local/user/user_repository.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/data/verify/verify_repository.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/models/user.dart';

@LazySingleton(as: Repository)
class RepositoryImpl extends Repository {
  final VerifyRepository _verifyRepository;
  final FirebaseRepository _firebaseRepository;
  final UserRepository _userRepository;
  final LocationDao _locationDao;

  RepositoryImpl(this._verifyRepository, this._firebaseRepository,
      this._userRepository, this._locationDao);

  @override
  Future<Option<User>> getSignedInUser() => _userRepository.getUser();

  @override
  Future<void> signOut() => _userRepository.delete();

  @override
  Future<Either<AuthFailure, User>> signIn(UserSignInRequest request) =>
      _firebaseRepository
          .signIn(request)
          .then((value) => value.fold((l) => left(l), (r) async {
                await _userRepository.insert(r);
                return right(r);
              }));

  @override
  Future<Either<VerifyFailure, String>> sendVerification(User user) =>
      _verifyRepository.sendVerification(user);

  @override
  Future<Either<VerifyFailure, Unit>> checkCode(String code) =>
      _verifyRepository.checkCode(code);

  @override
  Future<Either<AuthFailure, User>> signUp(UserRegisterRequest request) =>
      _firebaseRepository
          .createUser(request)
          .then((value) => value.fold((l) => left(l), (r) async {
                await _userRepository.insert(r);
                return right(r);
              }));

  @override
  Future<Either<VerifyFailure, Unit>> verifyPhone(String userId) =>
      _firebaseRepository.verifyPhone(userId);

  @override
  Future<Either<dynamic, Location>> getLocation(String type, String id) =>
      _firebaseRepository.getLocation(type, id);

  @override
  Future<Either<dynamic, Unit>> checkIn(Location location) async {
    print(location);

    await _locationDao
        .insertLocation(location)
        .catchError((error) => left(error));

    return right(unit);
  }

  @override
  Future<Either<dynamic, Location>> checkOut(Location location) async {
    location.checkedIn = false;
    location.checkOut = DateTime.now();

    await _locationDao
        .updateLocation(location)
        .catchError((error) => left(error));

    return right(location);
  }

  @override
  Stream<List<Location>> checkedInLocations() =>
      _locationDao.findCheckedInLocations();

  @override
  Stream<List<Location>> checkedOutLocations() =>
      _locationDao.findCheckedOutLocations();
}
