class UserRegisterRequest {
  final String name;
  final String nic;
  final String phoneNumber;
  final String password;

  UserRegisterRequest(
    this.name,
    this.nic,
    this.phoneNumber,
    this.password,
  );

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "nic": nic,
      "phoneNumber": phoneNumber,
      "password": password,
    };
  }
}
