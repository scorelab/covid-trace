import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/auth/auth_repository.dart';
import 'package:slcovid_tracker/models/user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Option<User>> getSignedInUser() async => optionOf(null);
  //need to implement

  @override
  Future<Either<AuthFailure, Unit>> signIn() async {}

  @override
  Future<void> signOut() => Future.wait([]);
}
