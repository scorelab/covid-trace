part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUserEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {}

class SendVerificationEvent extends AuthEvent {
  final UserRegisterRequest request;

  SendVerificationEvent({@required this.request});
}

class SignUpEvent extends AuthEvent {
  final UserRegisterRequest request;

  SignUpEvent({@required this.request});
}

class SignOutEvent extends AuthEvent {}
