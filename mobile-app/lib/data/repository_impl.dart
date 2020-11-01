import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/data/local/user_repository.dart';
import 'package:slcovid_tracker/data/verify/verify_repository.dart';
import 'package:slcovid_tracker/models/user.dart';

@LazySingleton(as: Repository)
class RepositoryImpl extends Repository {
  final VerifyRepository _verifyRepository;
  final FirebaseRepository _firebaseRepository;
  final UserRepository _userRepository;

  RepositoryImpl(
      this._verifyRepository, this._firebaseRepository, this._userRepository);

  @override
  Future<Option<User>> getSignedInUser() => _userRepository.getUser();

  @override
  Future<void> signOut() => _userRepository.delete();

  @override
  Future<Either<dynamic, User>> signIn(UserSignInRequest request) =>
      _firebaseRepository
          .signIn(request)
          .then((value) => value.fold((l) => left(l), (r) async {
                await _userRepository.insert(r);
                return right(r);
              }));

  @override
  Future<Either<VerifyFailure, Unit>> sendVerification(User user) =>
      _verifyRepository.sendVerification(user);

  @override
  Future<Either<dynamic, User>> signUp(UserRegisterRequest request) =>
      _firebaseRepository
          .createUser(request)
          .then((value) => value.fold((l) => left(l), (r) async {
                await _userRepository.insert(r);
                return right(r);
              }));

  @override
  Future<Either<dynamic, Unit>> verifyPhone(String userId) =>
      _firebaseRepository.verifyPhone(userId);
}
