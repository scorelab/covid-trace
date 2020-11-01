part of 'verify_bloc.dart';

abstract class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class SendVerificationEvent extends VerifyEvent {
  final User user;

  SendVerificationEvent({@required this.user});
}
