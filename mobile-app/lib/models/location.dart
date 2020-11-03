import 'package:floor/floor.dart';

@entity
class Location {
  @primaryKey
  final String id;

  final String name;
  final String address;
  final String type;
  DateTime time;

  Location(this.id, this.name, this.address, this.type) {
    this.time = DateTime.now();
  }
}

class BusLocation extends Location {
  final String locationId;
  final String busRouteNo;
  final String contactNumber;
  final String type;

  BusLocation(String id, String name, String busNo, this.locationId,
      this.busRouteNo, this.contactNumber, this.type)
      : super(id, name, busNo, 'sc_bus');

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
      : super(id, name, address, 'sc_location');

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
      : super(id, trainName, trainNo, 'sc_train');

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
      : super(id, name, vehicleNo, 'sc_vehicle');

  factory VehicleLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return VehicleLocation(id, document['name'], document['vehicle_no'],
        document['location_id'], document['contact_number']);
  }
}
