part of 'upload_bloc.dart';

abstract class UploadState extends Equatable {
  const UploadState();

  @override
  List<Object> get props => [];
}

class Initializing extends UploadState {}

class Loading extends UploadState {}

class DataUploadFailed extends UploadState {
  final dynamic error;

  DataUploadFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

class DataUploadSuccess extends UploadState {}

class NonInfected extends UploadState {}

class NoCode extends UploadState {}

class GotCode extends UploadState {
  final String code;

  GotCode({@required this.code});

  @override
  List<Object> get props => [code];
}
