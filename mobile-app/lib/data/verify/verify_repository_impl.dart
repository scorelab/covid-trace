import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/verify/verify_repository.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:sms/sms.dart';

@Injectable(as: VerifyRepository)
class VerifyRepositoryImpl extends VerifyRepository {
  // @override
  // Future<Option<User>> getSignedInUser() async => optionOf(null);

  @override
  Future<Either<VerifyFailure, String>> sendVerification(User user) async {
    var otpSendResult = await _sendOTP(user.phoneNumber);
    return otpSendResult.fold(
      (l) => left(l),
      (otp) => right(otp),
    );
  }

  @override
  Future<Either<VerifyFailure, Unit>> checkCode(String code) async {
    var receivedOtpResult = await _listenOTP(code);
    return receivedOtpResult.fold(
      (l) => left(l),
      (_) {
        return right(unit);
      },
    );
  }

  Future<Either<VerifyFailure, String>> _sendOTP(String phoneNumber) async {
    final code = Random().nextInt(999999);
    SmsSender sender = SmsSender();
    await sender
        .sendSms(SmsMessage(phoneNumber, "covid trace OPT: ${code}"))
        .catchError((onError) {
      left(OTPSendFailure());
    });
    return right(code.toString());
  }

  Future<Either<VerifyFailure, String>> _listenOTP(String code) async {
    SmsReceiver receiver = new SmsReceiver();
    var result = await receiver.onSmsReceived
        .timeout(Duration(seconds: 5), onTimeout: (EventSink sink) {
          sink.close();
        })
        .singleWhere((sms) => sms.body.contains(code))
        .catchError((onError) {
          left(OTPReadFailure());
        });
    return right(result.body);
  }
}
