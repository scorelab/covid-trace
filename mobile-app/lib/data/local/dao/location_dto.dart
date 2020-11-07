import 'package:floor/floor.dart';
import 'package:slcovid_tracker/models/location.dart';

@dao
abstract class LocationDao {
  @Query('SELECT * FROM Location')
  Stream<List<Location>> findAllLocations();

  @Query('SELECT * FROM Location WHERE checkedIn = 0 ORDER BY checkOut DESC')
  Stream<List<Location>> findCheckedOutLocations();

  @Query('SELECT * FROM Location WHERE checkedIn = 1 ORDER BY checkIn DESC')
  Stream<List<Location>> findCheckedInLocations();

  @Query('SELECT * FROM Location WHERE id = :id')
  Future<Location> findLocationById(String id);

  @insert
  Future<void> insertLocation(Location location);

  @update
  Future<int> updateLocation(Location location);
}
