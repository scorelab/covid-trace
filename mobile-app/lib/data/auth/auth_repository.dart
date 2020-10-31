import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class AuthRepository {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> signIn();
  Future<void> signOut();
}
