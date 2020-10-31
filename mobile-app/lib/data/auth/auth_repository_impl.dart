import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/auth/auth_repository.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:sms/sms.dart';

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
  Future<Either<AuthFailure, Unit>> signUp(UserRegisterRequest request) async {
    var otpSendResult = await _sendOTP(request.phoneNumber);
    return otpSendResult.fold(
      (l) => left(l),
      (otp) async {
        final receivedOtpResult = await _listenOTP();
        return receivedOtpResult.fold(
          (l) => left(l),
          (_) {
            return right(unit);
          },
        );
      },
    );
  }

  Future<Either<AuthFailure, String>> _sendOTP(String phoneNumber) async {
    final code = Random().nextInt(999999);
    SmsSender sender = SmsSender();
    var _result = await sender
        .sendSms(SmsMessage(phoneNumber, "covid trace OPT: ${code}"))
        .catchError((onError) {
      left(OTPSendFailure());
    });
    return right(code.toString());
  }

  Future<Either<AuthFailure, Unit>> _listenOTP() async {
    SmsReceiver receiver = new SmsReceiver();
    await receiver.onSmsReceived.first.catchError((onError) {
      left(OTPReadFailure());
    });
    return right(unit);
  }
}
