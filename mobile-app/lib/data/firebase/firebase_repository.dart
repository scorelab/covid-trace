import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class FirebaseRepository {
  Future<Either<dynamic, User>> createUser(UserRegisterRequest request);
  Future<Either<dynamic, Unit>> verifyPhone(String userId);
}
