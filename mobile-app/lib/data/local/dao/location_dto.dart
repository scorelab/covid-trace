import 'package:floor/floor.dart';
import 'package:slcovid_tracker/models/location.dart';

@dao
abstract class LocationDao {
  @Query('SELECT * FROM Location')
  Stream<List<Location>> findAllLocations();

  @Query('SELECT * FROM Location WHERE id = :id')
  Future<Location> findLocationById(String id);

  @insert
  Future<void> insertLocation(Location location);
}
