import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class Repository {
  Future<Option<User>> getSignedInUser();
  Future<Either<AuthFailure, User>> signIn(UserSignInRequest request);
  Future<Either<AuthFailure, User>> signUp(UserRegisterRequest request);
  Future<void> signOut();

  Future<Either<VerifyFailure, String>> sendVerification(User request);
  Future<Either<VerifyFailure, Unit>> checkCode(String code);
  Future<Either<VerifyFailure, Unit>> verifyPhone(String userId);

  Future<Either<dynamic, Location>> getLocation(String type, String id);

  Future<Either<dynamic, Unit>> checkIn(Location location);
  Future<Either<dynamic, Location>> checkOut(Location location);
  Stream<List<Location>> checkedInLocations();
  Stream<List<Location>> checkedOutLocations();

  Stream<List<Location>> getExposedLocations();
  Future<Either<dynamic, List<Location>>> getExposedLocationsOnce();
  Future<List<Location>> getNonExposedLocations();
  Future<Either<dynamic, Unit>> expose(Location location);

  Future<Either<dynamic, String>> getInfectedCode(String userId);
  Future<Either<dynamic, Unit>> uploadData(User user, List<Location> locations);
}
