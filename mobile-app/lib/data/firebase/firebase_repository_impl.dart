import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/core/failures/verify_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository.dart';
import 'package:slcovid_tracker/models/infected.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:crypto/crypto.dart';

@Injectable(as: FirebaseRepository)
class FirebaseRepositoryImpl extends FirebaseRepository {
  @override
  Future<Either<AuthFailure, User>> createUser(
      UserRegisterRequest request) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var hashedNic = sha256.convert(utf8.encode(request.nic)).toString();
    var hashedPassword =
        sha256.convert(utf8.encode(request.password)).toString();

    QuerySnapshot querySnapshot = await users
        .where('phoneNumber', isEqualTo: request.phoneNumber)
        .get()
        .catchError((error) => left(UnknownAuthError(error: error)));

    if (querySnapshot.size > 0) {
      print(querySnapshot.size);
      return left(UserAlreadyExists());
    }

    var user = await users
        .add({
          'nic': hashedNic,
          'numberVerified': false,
          'phoneNumber': request.phoneNumber,
          'password': hashedPassword,
          'user_type': 'normal'
        })
        .then((ref) => ref.get())
        .catchError((error) => left(UnknownAuthError(error: error)));

    return right(User.fromFirebase(user.id, user.data()));
  }

  @override
  Future<Either<AuthFailure, User>> signIn(UserSignInRequest request) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var hashedPassword =
        sha256.convert(utf8.encode(request.password)).toString();

    QuerySnapshot querySnapshot = await users
        .where('phoneNumber', isEqualTo: request.phoneNumber)
        .get()
        .catchError((error) => left(UnknownAuthError(error: error)));

    if (querySnapshot.size > 0 && querySnapshot.docs[0].exists) {
      var documentSnapshot = querySnapshot.docs[0];
      var user =
          User.fromFirebase(documentSnapshot.id, documentSnapshot.data());

      if (user.password == hashedPassword) {
        return right(user);
      }
    }

    return left(InvalidCredentials());
  }

  @override
  Future<Either<VerifyFailure, Unit>> verifyPhone(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    print("Verifying " + userId);
    await users.doc(userId).update({
      'numberVerified': true,
    }).catchError((error) => left(UnknownVerifyError(error: error)));

    return right(unit);
  }

  @override
  Future<Either<dynamic, Location>> getLocation(String type, String id) async {
    CollectionReference locations = FirebaseFirestore.instance.collection(type);

    var document =
        await locations.doc(id).get().catchError((error) => left(error));

    switch (type) {
      case 'sc_bus':
        return right(BusLocation.fromFirebase(id, document.data()));
        break;
      case 'sc_location':
        return right(LocationLocation.fromFirebase(id, document.data()));
        break;
      case 'sc_train':
        return right(TrainLocation.fromFirebase(id, document.data()));
        break;
      case 'sc_vehicle':
        return right(VehicleLocation.fromFirebase(id, document.data()));
        break;
      default:
        return left(null);
    }
  }

  @override
  Future<Either<dynamic, String>> getInfectedCode(String userId) async {
    CollectionReference infected =
        FirebaseFirestore.instance.collection('sc_infected_user');

    var codeData =
        await infected.doc(userId).get().catchError((err) => left(err));

    if (codeData.exists) {
      return right(codeData.data()['code']);
    } else {
      return left("No code found");
    }
  }

  @override
  Future<Either<dynamic, Unit>> uploadData(
      User user, List<Location> locations) async {
    CollectionReference infected =
        FirebaseFirestore.instance.collection('sc_infected_check_in_out');

    DateTime lastDate = DateTime.now().subtract(Duration(days: 14));

    var futures =
        locations.where((e) => e.checkOut.isAfter(lastDate)).map((location) {
      return {
        'check_in_time': location.checkIn,
        'check_out_time': location.checkOut,
        'location_id': location.id,
        'location_type': location.type,
        'upload_time': FieldValue.serverTimestamp(),
        'user_phone_number': user.phoneNumber,
      };
    }).map((mapped) => infected.add(mapped));

    await Future.wait(futures).catchError((err) => left(err));

    CollectionReference infectedUsers =
        FirebaseFirestore.instance.collection('sc_infected_user');

    await infectedUsers
        .doc(user.id)
        .update({'code': null}).catchError((err) => left(err));

    return right(unit);
  }
}
