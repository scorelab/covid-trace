import 'package:flutter/foundation.dart';
import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class AuthFailure extends Failure {}

class UnknownAuthError extends AuthFailure {
  final dynamic error;

  UnknownAuthError({@required this.error});
}

class InvalidCredentials extends AuthFailure {}

class UserAlreadyExists extends AuthFailure {}
