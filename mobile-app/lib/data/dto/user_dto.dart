class UserRegisterRequest {
  final String nic;
  final String phoneNumber;
  final String password;

  UserRegisterRequest(
    this.nic,
    this.phoneNumber,
    this.password,
  );

  Map<String, dynamic> toMap() {
    return {
      "nic": nic,
      "phoneNumber": phoneNumber,
      "password": password,
    };
  }
}
