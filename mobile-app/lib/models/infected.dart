import 'package:cloud_firestore/cloud_firestore.dart';

class InfectedLocation {
  final String id;
  final String locationId;
  final String locationType;
  final DateTime checkIn;
  final DateTime checkOut;
  final DateTime uploadTime;

  InfectedLocation(this.id, this.locationId, this.locationType, this.checkIn,
      this.checkOut, this.uploadTime);

  factory InfectedLocation.fromFirebase(
      String id, Map<String, dynamic> document) {
    return InfectedLocation(
      id,
      document['location_id'],
      document['location_type'],
      (document['check_in_time'] as Timestamp).toDate(),
      (document['check_out_time'] as Timestamp).toDate(),
      (document['upload_time'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return id +
        ", " +
        locationId +
        ", " +
        locationType +
        ", " +
        checkIn.toString() +
        " -> " +
        checkOut.toString() +
        ", " +
        uploadTime.toString();
  }
}
