part of 'verify_bloc.dart';

abstract class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

class Initializing extends VerifyState {}

class VerifyLoading extends VerifyState {}

class VerifyFailed extends VerifyState {
  final VerifyFailure error;

  VerifyFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

class SentVerification extends VerifyState {
  final User user;

  SentVerification({@required this.user});

  @override
  List<Object> get props => [user];
}

class CodeReceived extends VerifyState {
  final User user;

  CodeReceived({@required this.user});

  @override
  List<Object> get props => [user];
}

