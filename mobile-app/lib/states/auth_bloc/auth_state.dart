part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Initializing extends AuthState {}

class Loading extends AuthState {}

class Failed extends AuthState {
  final AuthFailure error;

  Failed({@required this.error});

  @override
  List<Object> get props => [error];
}

class SentVerification extends AuthState {
  final UserRegisterRequest request;

  SentVerification({@required this.request});

  @override
  List<Object> get props => [request];
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
