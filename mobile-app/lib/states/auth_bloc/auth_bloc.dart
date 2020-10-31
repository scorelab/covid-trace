import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/repository.dart';

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
  ) async* {}
}
