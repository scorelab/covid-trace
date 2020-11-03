import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class VerifyRepository {
  Future<Either<VerifyFailure, String>> sendVerification(User user);
  Future<Either<VerifyFailure, Unit>> checkCode(String code);
}
