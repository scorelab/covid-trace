import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class AuthFailure extends Failure {}

class LoginFailure extends AuthFailure {}

class OTPSendFailure extends AuthFailure {}

class OTPReadFailure extends AuthFailure {}

class OTPMismatchFailure extends AuthFailure {}
