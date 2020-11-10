part of 'exposed_bloc.dart';

abstract class ExposedState extends Equatable {
  const ExposedState();

  @override
  List<Object> get props => [];
}

class Initializing extends ExposedState {}

class Updating extends ExposedState {}

class UpdateSuccess extends ExposedState {}

class UpdateFailed extends ExposedState {
  final dynamic error;

  UpdateFailed({@required this.error});

  @override
  List<Object> get props => [error];
}
