import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/auth/auth_repository.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/user.dart';

@LazySingleton(as: Repository)
class RepositoryImpl extends Repository {
  final AuthRepository _authRepository;

  RepositoryImpl(this._authRepository);

  @override
  Future<Option<User>> getSignedInUser() => _authRepository.getSignedInUser();

  @override
  Future<void> signOut() => _authRepository.signOut();

  @override
  Future<Either<AuthFailure, Unit>> signIn() => _authRepository.signIn();

  @override
  Future<Either<AuthFailure, Unit>> sendVerification(UserRegisterRequest request) =>
      _authRepository.sendVerification(request);

  @override
  Future<Either<AuthFailure, Unit>> signUp(UserRegisterRequest request) =>
      _authRepository.signUp(request);
}
