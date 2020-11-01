part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Initializing extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final AuthFailure error;

  AuthFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

class SentVerification extends AuthState {
  final User user;

  SentVerification({@required this.user});

  @override
  List<Object> get props => [user];
}

class CodeReceived extends AuthState {
  final User user;

  CodeReceived({@required this.user});

  @override
  List<Object> get props => [user];
}


class Authenticated extends AuthState {
  final User user;

  Authenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}
