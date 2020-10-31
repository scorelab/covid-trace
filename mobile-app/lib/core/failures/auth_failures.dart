import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class AuthFailure extends Failure {}

class PlatformFailure extends AuthFailure {}

class FacebookFailure extends AuthFailure {}

class CancelByUserFailure extends AuthFailure {}
