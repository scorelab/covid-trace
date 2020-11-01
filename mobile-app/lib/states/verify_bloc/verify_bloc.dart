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

  VerifyBloc(this._repository,) : super(Initializing());

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event,) async* {
    print(event);

    yield VerifyLoading();
    if (event is SendVerificationEvent) {
      yield SentVerification(user: event.user);
      yield (await _repository.sendVerification(event.user))
          .fold<VerifyState>(
            (l) => VerifyFailed(error: l),
            (r) => CodeReceived(user: event.user),
      );
    }
  }
}
