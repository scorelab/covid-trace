part of 'upload_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class GetExposedEvent extends UploadEvent {}

class GetCodeEvent extends UploadEvent {}

class UploadDataEvent extends UploadEvent {
  final String code;

  UploadDataEvent({@required this.code});
}
