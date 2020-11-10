import 'package:floor/floor.dart';

@entity
class Location {
  @PrimaryKey(autoGenerate: true)
  final int pk;

  final String id;
  final String name;
  final String address;
  final String type;
  DateTime checkIn;
  DateTime checkOut;
  bool checkedIn;
  bool exposed;

  Location(this.pk, this.id, this.name, this.address, this.type, this.checkIn,
      this.checkOut, this.checkedIn, this.exposed);

  factory Location.create(String id, String name, String address, String type) {
    return Location(null, id, name, address, type, DateTime.now(),
        DateTime.fromMicrosecondsSinceEpoch(0), true, false);
  }

  @override
  String toString() {
    return pk.toString() +
        ", " +
        id +
        ", " +
        name +
        ", " +
        type +
        ", " +
        checkIn.toString() +
        " -> " +
        checkOut.toString() +
        ", " +
        checkedIn.toString() +
        ", " +
        exposed.toString();
  }
}

class BusLocation extends Location {
  final String locationId;
  final String busRouteNo;
  final String contactNumber;
  final String type;

  BusLocation(String id, String name, String busNo, this.locationId,
      this.busRouteNo, this.contactNumber, this.type)
      : super(null, id, name, busNo, 'sc_bus', DateTime.now(),
            DateTime.fromMillisecondsSinceEpoch(0), true, false);

  factory BusLocation.fromFirebase(String id, Map<String, dynamic> document) {
    return BusLocation(
      id,
      document['name'],
      document['bus_no'],
      document['location_id'],
      document['bus_route_no'],
      document['contact_number'],
      document['type'],
    );
  }
}

class LocationLocation extends Location {
  final String locationId;
  final String postalCode;
  final String city;
  final String district;
  final String province;
  final String floorNo;
  final String premiseType;
  final String unitType;

  LocationLocation(
      String id,
      String name,
      String address,
      this.locationId,
      this.postalCode,
      this.city,
      this.district,
      this.province,
      this.floorNo,
      this.premiseType,
      this.unitType)
      : super(null, id, name, address, 'sc_location', DateTime.now(),
            DateTime.fromMillisecondsSinceEpoch(0), true, false);

  factory LocationLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return LocationLocation(
      id,
      document['name'],
      document['address'],
      document['location_id'],
      document['postal_code'],
      document['city'],
      document['district'],
      document['province'],
      document['floor_no'],
      document['premise_type'],
      document['unit_type'],
    );
  }
}

class TrainLocation extends Location {
  final String locationId;
  final String carriageNo;
  final String type;

  TrainLocation(String id, String trainName, String trainNo, this.locationId,
      this.carriageNo, this.type)
      : super(null, id, trainName, trainNo, 'sc_train', DateTime.now(),
            DateTime.fromMillisecondsSinceEpoch(0), true, false);

  factory TrainLocation.fromFirebase(String id, Map<String, dynamic> document) {
    return TrainLocation(id, document['train_name'], document['train_no'],
        document['location_id'], document['carriage_no'], document['type']);
  }
}

class VehicleLocation extends Location {
  final String locationId;
  final String contactNumber;

  VehicleLocation(String id, String name, String vehicleNo, this.locationId,
      this.contactNumber)
      : super(null, id, name, vehicleNo, 'sc_vehicle', DateTime.now(),
            DateTime.fromMillisecondsSinceEpoch(0), true, false);

  factory VehicleLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return VehicleLocation(id, document['name'], document['vehicle_no'],
        document['location_id'], document['contact_number']);
  }
}
