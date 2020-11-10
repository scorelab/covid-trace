import 'package:floor/floor.dart';
import 'package:slcovid_tracker/models/location.dart';

@dao
abstract class LocationDao {
  @Query('SELECT * FROM Location')
  Future<List<Location>> findAllLocations();

  @Query('SELECT * FROM Location WHERE checkedIn = 0 ORDER BY checkOut DESC')
  Stream<List<Location>> findCheckedOutLocations();

  @Query('SELECT * FROM Location WHERE checkedIn = 1 ORDER BY checkIn DESC')
  Stream<List<Location>> findCheckedInLocations();

  @Query('SELECT * FROM Location WHERE id = :id')
  Future<Location> findLocationById(String id);

  @Query('SELECT * FROM Location WHERE exposed = 0')
  Future<List<Location>> findNonExposedLocations();

  @Query('SELECT * FROM Location WHERE exposed = 1')
  Stream<List<Location>> findExposedLocations();

  @insert
  Future<void> insertLocation(Location location);

  @update
  Future<int> updateLocation(Location location);
}
