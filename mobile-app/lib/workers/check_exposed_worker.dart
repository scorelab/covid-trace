import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slcovid_tracker/data/local/dao/location_dto.dart';
import 'package:slcovid_tracker/data/local/database/database.dart';
import 'package:slcovid_tracker/models/infected.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:workmanager/workmanager.dart';

void checkExposedCallback() {
  Workmanager.executeTask((task, inputData) {
    print("Heelo");
    return _updateExposed()
        .catchError((err) => print("sexx"))
        .then((value) => true);
  });
}

Future<Either<dynamic, Unit>> _updateExposed() async {
  await Firebase.initializeApp();

  LocationDao doa = await $FloorAppDatabase
      .databaseBuilder('database.db')
      .build()
      .then((value) => value.locationDao);

  var locations = await doa.findNonExposedLocations();

  String uploadTime = await SharedPreferences.getInstance()
      .then((pref) => pref.getString("upload_time"));
  print(uploadTime);

  var infected = await _getInfectedLocations(uploadTime != null
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

  await Future.wait(exposed.map((e) => _expose(doa, e)));

  print(exposed);
  return right(unit);
}

Future<Either<dynamic, List<InfectedLocation>>> _getInfectedLocations(
    DateTime after) async {
  CollectionReference locations =
      FirebaseFirestore.instance.collection('sc_infected_check_in_out');

  var document = await locations
      .where('upload_time', isGreaterThan: after)
      .orderBy('upload_time', descending: true)
      .get()
      .catchError((error) => left(error));

  return right(document.docs
      .map((e) => InfectedLocation.fromFirebase(e.id, e.data()))
      .toList());
}

Future<Either<dynamic, Unit>> _expose(
  LocationDao _locationDao,
  Location location,
) async {
  location.exposed = true;

  await _locationDao
      .updateLocation(location)
      .catchError((error) => left(error));

  return right(unit);
}
