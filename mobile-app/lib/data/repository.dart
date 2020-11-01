import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class Repository {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> signIn();
  Future<Either<AuthFailure, Unit>> sendVerification(UserRegisterRequest request);
  Future<Either<AuthFailure, Unit>> signUp(UserRegisterRequest request);
  Future<void> signOut();
}
