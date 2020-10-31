import 'package:flutter/foundation.dart';

class UserDto {
  final String id;
  final String name;
  final String phoneNumber;
  final String password;

  UserDto({
    @required this.id,
    @required this.name,
    @required this.phoneNumber,
    @required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "password": password,
    };
  }
}
