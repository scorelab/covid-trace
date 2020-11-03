import 'dart:async';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/data/local/dao/location_dto.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:slcovid_tracker/models/location.dart';

part 'database.g.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Location])
abstract class AppDatabase extends FloorDatabase {
  LocationDao get locationDao;
}

@module
abstract class LocationModule {
  @preResolve
  Future<LocationDao> get prefs =>
      $FloorAppDatabase.databaseBuilder('database.db').build().then((
          value) => value.locationDao);
}
