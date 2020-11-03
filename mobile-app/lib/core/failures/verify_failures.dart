import 'package:flutter/foundation.dart';
import 'package:slcovid_tracker/core/failures/failure.dart';

abstract class VerifyFailure extends Failure {}

class OTPSendFailure extends VerifyFailure {}

class OTPReadFailure extends VerifyFailure {}

class OTPMismatchFailure extends VerifyFailure {}

class UnknownVerifyError extends VerifyFailure {
  final dynamic error;

  UnknownVerifyError({@required this.error});
}
