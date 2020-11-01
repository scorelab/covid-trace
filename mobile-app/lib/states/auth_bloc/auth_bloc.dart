import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Repository _repository;

  AuthBloc(
    this._repository,
  ) : super(Initializing());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    print(event);

    yield AuthLoading();
    if (event is GetCurrentUserEvent) {
      yield (await _repository.getSignedInUser()).fold<AuthState>(
        () => Unauthenticated(),
        (_) => Authenticated(user: User('', '', false, '', '')),
      );
    }

    if (event is SignUpEvent) {
      yield (await _repository.signUp(event.request)).fold<AuthState>(
        (l) => AuthFailed(error: l),
        (r) => Authenticated(user: r),
      );
    }

    if (event is SignInEvent) {
      yield (await _repository.signIn()).fold<AuthState>(
        (l) => AuthFailed(error: l),
        (r) => Authenticated(user: User('', '', false, '', '')),
      );
    }

    if (event is SignOutEvent) {
      await _repository.signOut();
      yield Unauthenticated();
    }
  }
}
