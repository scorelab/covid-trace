import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/auth/auth_repository.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Option<User>> getSignedInUser() async => optionOf(null);
  //need to implement

  @override
  Future<Either<AuthFailure, Unit>> signIn() async {
    return left(LoginFailure());
  }

  @override
  Future<void> signOut() => Future.wait([]);

  @override
  Future<Either<AuthFailure, Unit>> signUp(UserRegisterRequest request) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
