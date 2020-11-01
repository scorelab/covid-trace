part of 'verify_bloc.dart';

abstract class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class SendVerificationEvent extends VerifyEvent {}

class VerifyPhoneEvent extends VerifyEvent {
  final String userId;

  VerifyPhoneEvent({@required this.userId});
}

