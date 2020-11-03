class User {
  final String id;
  final String phoneNumber;
  final bool numberVerified;
  final String nic;
  final String password;
  final String userType;

  User(this.id, this.phoneNumber, this.numberVerified, this.nic, this.password,
      this.userType);

  factory User.fromFirebase(String id, Map<String, dynamic> document) {
    return User(id, document['phoneNumber'], document['numberVerified'],
        document['nic'], document['password'], document['user_type']);
  }
}
