import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class FirebaseRepository {
  Future<Either<AuthFailure, User>> createUser(UserRegisterRequest request);
  Future<Either<AuthFailure, User>> signIn(UserSignInRequest request);
  Future<Either<VerifyFailure, Unit>> verifyPhone(String userId);
  Future<Either<dynamic, Location>> getLocation(String type, String id);
  Future<Either<dynamic, String>> getInfectedCode(String userId);
  Future<Either<dynamic, Unit>> uploadData(User user, List<Location> locations);
}
