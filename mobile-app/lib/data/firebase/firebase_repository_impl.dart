import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:slcovid_tracker/core/failures/auth_failures.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/data/firebase/firebase_repository.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:crypto/crypto.dart';

@Injectable(as: FirebaseRepository)
class FirebaseRepositoryImpl extends FirebaseRepository {
  @override
  Future<Either<dynamic, User>> createUser(UserRegisterRequest request) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var hashedNic = sha256.convert(utf8.encode(request.nic)).toString();
    var hashedPassword =
        sha256.convert(utf8.encode(request.password)).toString();

    QuerySnapshot querySnapshot = await users
        .where('phoneNumber', isEqualTo: request.phoneNumber)
        .get()
        .catchError((error) => left(error));

    if (querySnapshot.size > 0) {
      print(querySnapshot.size);
      return left(SignUpFailure());
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
        .catchError((error) => left(error));

    return right(User.fromFirebase(user.id, user.data()));
  }

  @override
  Future<Either<dynamic, User>> signIn(UserSignInRequest request) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var hashedPassword =
        sha256.convert(utf8.encode(request.password)).toString();

    QuerySnapshot querySnapshot = await users
        .where('phoneNumber', isEqualTo: request.phoneNumber)
        .get()
        .catchError((error) => left(error));

    if (querySnapshot.size > 0 && querySnapshot.docs[0].exists) {
      var documentSnapshot = querySnapshot.docs[0];
      var user =
          User.fromFirebase(documentSnapshot.id, documentSnapshot.data());

      if (user.password == hashedPassword) {
        return right(user);
      }
    }

    return left(LoginFailure());
  }

  @override
  Future<Either<dynamic, Unit>> verifyPhone(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(userId).set({
      'phoneNumber': true,
    }).catchError((error) => left(error));

    return right(unit);
  }
}
