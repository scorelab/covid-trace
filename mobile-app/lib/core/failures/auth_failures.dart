import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class AuthFailure extends Failure {}

class LoginFailure extends AuthFailure {}

class SignUpFailure extends AuthFailure {}
