import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/location.dart';

part 'exposed_event.dart';
part 'exposed_state.dart';

@Injectable()
class ExposedBloc extends Bloc<ExposedEvent, ExposedState> {
  final Repository _repository;

  ExposedBloc(this._repository) : super(Initializing());

  @override
  Stream<ExposedState> mapEventToState(
    ExposedEvent event,
  ) async* {}

  Stream<List<Location>> get exposedLocations {
    return _repository.getExposedLocations();
  }
}
