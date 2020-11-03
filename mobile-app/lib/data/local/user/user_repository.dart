import 'package:dartz/dartz.dart';
import 'package:slcovid_tracker/models/user.dart';

abstract class UserRepository {
  Future<void> insert(User user);
  Future<Option<User>> getUser();
  Future<void> delete();
}
