import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class Repository {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> signIn();
  Future<Either<dynamic, User>> signUp(UserRegisterRequest request);
  Future<void> signOut();

  Future<Either<VerifyFailure, Unit>> sendVerification(User request);
  Future<Either<dynamic, Unit>> verifyPhone(String userId);
}
