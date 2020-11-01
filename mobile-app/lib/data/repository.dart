import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class Repository {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, User>> signIn(UserSignInRequest request);
  Future<Either<AuthFailure, User>> signUp(UserRegisterRequest request);
  Future<void> signOut();

  Future<Either<VerifyFailure, String>> sendVerification(User request);
  Future<Either<VerifyFailure, Unit>> checkCode(String code);
  Future<Either<VerifyFailure, Unit>> verifyPhone(String userId);
}
