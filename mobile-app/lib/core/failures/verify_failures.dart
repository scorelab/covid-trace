import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class VerifyFailure extends Failure {}

class OTPSendFailure extends VerifyFailure {}

class OTPReadFailure extends VerifyFailure {}

class OTPMismatchFailure extends VerifyFailure {}
