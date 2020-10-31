part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Initializing extends AuthState {}

class SigningIn extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}
