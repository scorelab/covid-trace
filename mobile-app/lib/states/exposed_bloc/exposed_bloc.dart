import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slcovid_tracker/data/repository.dart';
import 'package:slcovid_tracker/models/infected.dart';
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
  ) async* {
    if (event is UpdateExposedEvent) {
      yield Updating();

      yield (await updateExposed())
          .fold((l) => UpdateFailed(error: l), (r) => UpdateSuccess());
    }
  }

  Stream<List<Location>> get exposedLocations {
    return _repository.getExposedLocations();
  }

  Future<Either<dynamic, Unit>> updateExposed() async {
    var locations = await _repository.getNonExposedLocations();

    String uploadTime = await SharedPreferences.getInstance()
        .then((pref) => pref.getString("upload_time"));
    print(uploadTime);

    var infected = await _repository
        .getInfectedLocations(uploadTime != null
            ? DateTime.parse(uploadTime)
            : DateTime.utc(1989, 11, 9))
        .catchError((err) => left(err));

    List<Location> exposed = [];

    infected.fold((l) => print(l), (infectedLocations) {
      print(infectedLocations);
      infectedLocations.forEach((infectedLocation) {
        locations.forEach((location) {
          if (location.id == infectedLocation.locationId) {
            var checkInWhileInfected =
                location.checkIn.isBefore(infectedLocation.checkOut);
            var checkOutAfterInfected =
                location.checkOut.isAfter(infectedLocation.checkIn);

            if (checkInWhileInfected || checkOutAfterInfected) {
              exposed.add(location);
            }
          }
        });
      });
      if (infectedLocations.length > 0) {
        SharedPreferences.getInstance().then((pref) => pref.setString(
            "upload_time", infectedLocations[0].uploadTime.toString()));
      }
    });

    await Future.wait(exposed.map((e) => _repository.expose(e)));

    print(exposed);
    return right(unit);
  }
}
