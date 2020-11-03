part of 'checkin_bloc.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();

  @override
  List<Object> get props => [];
}

class Initializing extends CheckInState {}

class Fetching extends CheckInState {}

class Checking extends CheckInState {}

class FetchSuccess extends CheckInState {
  final Location location;

  FetchSuccess({@required this.location});

  @override
  List<Object> get props => [location];
}

class FetchFailed extends CheckInState {
  final dynamic error;

  FetchFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

class CheckSuccess extends CheckInState {}

class CheckFailed extends CheckInState {
  final dynamic error;

  CheckFailed({@required this.error});

  @override
  List<Object> get props => [error];
}

class InvalidQR extends CheckInState {}
