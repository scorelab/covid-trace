class Location {
  final String id;
  final String locationId;

  Location(this.id, this.locationId);
}

class BusLocation extends Location {
  final String name;
  final String busNo;
  final String busRouteNo;
  final String contactNumber;
  final String type;

  BusLocation(String id, String locationId, this.name, this.busNo,
      this.busRouteNo, this.contactNumber, this.type)
      : super(id, locationId);

  factory BusLocation.fromFirebase(String id, Map<String, dynamic> document) {
    return BusLocation(
      id,
      document['location_id'],
      document['name'],
      document['bus_no'],
      document['bus_route_no'],
      document['contact_number'],
      document['type'],
    );
  }
}

class LocationLocation extends Location {
  final String name;
  final String address;
  final String postalCode;
  final String city;
  final String district;
  final String province;
  final String floorNo;
  final String premiseType;
  final String unitType;

  LocationLocation(
      String id,
      String locationId,
      this.name,
      this.address,
      this.postalCode,
      this.city,
      this.district,
      this.province,
      this.floorNo,
      this.premiseType,
      this.unitType)
      : super(id, locationId);

  factory LocationLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return LocationLocation(
      id,
      document['location_id'],
      document['name'],
      document['address'],
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
  final String trainName;
  final String trainNo;
  final String carriageNo;
  final String type;

  TrainLocation(String id, String locationId, this.trainName, this.trainNo,
      this.carriageNo, this.type)
      : super(id, locationId);

  factory TrainLocation.fromFirebase(String id, Map<String, dynamic> document) {
    return TrainLocation(id, document['location_id'], document['train_name'],
        document['train_no'], document['carriage_no'], document['type']);
  }
}

class VehicleLocation extends Location {
  final String name;
  final String vehicleNo;
  final String contactNumber;

  VehicleLocation(String id, String locationId, this.name, this.vehicleNo,
      this.contactNumber)
      : super(id, locationId);

  factory VehicleLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return VehicleLocation(id, document['location_id'], document['name'],
        document['vehicle_no'], document['contact_number']);
  }
}
