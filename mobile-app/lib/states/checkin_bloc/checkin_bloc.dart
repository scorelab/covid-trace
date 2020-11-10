import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';

part 'checkin_event.dart';

part 'checkin_state.dart';

@Injectable()
class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final Repository _repository;

  CheckInBloc(this._repository) : super(Initializing());

  @override
  Stream<CheckInState> mapEventToState(
    CheckInEvent event,
  ) async* {
    if (event is FetchLocationEvent) {
      yield Fetching();
      Location qRLocation = _parseUrl(event.args);

      if (qRLocation != null) {
        yield FetchSuccess(location: qRLocation);
      } else
        yield InvalidQR();
    }

    if (event is CheckEvent) {
      yield Checking();

      yield (await _repository.checkIn(event.location))
          .fold((l) => CheckFailed(error: l), (r) => CheckSuccess());
    }
  }

  Stream<List<Location>> get checkedInLocations {
    return _repository.checkedInLocations();
  }

  Stream<List<Location>> get checkedOutLocations {
    return _repository.checkedOutLocations();
  }

  Future<Either<dynamic, Location>> checkOut(Location location) {
    return _repository.checkOut(location);
  }

  Location _parseUrl(SafeEntryBeforeCheckInScreenArgs args) {
    if (args == null) return null;

    String type;
    String id;
    String name;

    // https://safecheckin.com/sc_bus/AXeyPFiEpYBGIfyasNGr?name=Nimal Travels
    var uri = Uri.parse(args.url);
    if (uri.pathSegments.length > 1) {
      type = uri.pathSegments[0];
      id = uri.pathSegments[1];
    } else
      return null;

    if (uri.queryParameters.containsKey('name')) {
      name = uri.queryParameters['name'];
    } else
      return null;

    // Parse id, name, address, type
    return Location.create(id, name, "", type);
  }
}
