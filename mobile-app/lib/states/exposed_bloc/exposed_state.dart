part of 'exposed_bloc.dart';

abstract class ExposedState extends Equatable {
  const ExposedState();

  @override
  List<Object> get props => [];
}

class Initializing extends ExposedState {}
