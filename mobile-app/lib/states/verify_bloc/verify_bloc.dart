import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/user.dart';

part 'verify_event.dart';

part 'verify_state.dart';

@Injectable()
class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final Repository _repository;

  VerifyBloc(
    this._repository,
  ) : super(Initializing());

  @override
  Stream<VerifyState> mapEventToState(
    VerifyEvent event,
  ) async* {
    print(event);

    yield VerifyLoading();
    if (event is SendVerificationEvent) {
      User user = (await _repository.getSignedInUser()).getOrElse(() => null);

      if (user != null) {
        var sent = (await _repository.sendVerification(user)).fold<VerifyState>(
          (l) => VerifyFailed(error: l),
          (r) => SentVerification(code: r, user: user),
        );
        yield sent;

        if (sent is SentVerification) {
          yield (await _repository.checkCode(sent.code)).fold<VerifyState>(
            (l) => VerifyFailed(error: l),
            (r) => CodeReceived(),
          );
        }
      }
    }

    if (event is VerifyPhoneEvent) {
      yield (await _repository.verifyPhone(event.userId)).fold<VerifyState>(
        (l) => VerifyFailed(error: l),
        (r) => VerifySuccess(),
      );
    }
  }
}
