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

  Location _parseUrl(args) {
    // TODO - Update parsing logic based on the QR design
    if (args == null) return null;

    var data = args.url.split('/')[3].split("|");

    // Parse id, name, address, type
    return Location.create(data[1], data[2], data[3], data[0]);
  }
}
