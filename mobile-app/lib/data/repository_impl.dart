import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
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
}
