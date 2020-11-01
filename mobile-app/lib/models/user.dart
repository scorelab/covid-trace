class User {
  final String id;
  final String phoneNumber;
  final bool phoneVerified;
  final String nic;
  final String password;
  final String userType;

  User(this.id, this.phoneNumber, this.phoneVerified, this.nic, this.password,
      this.userType);

  factory User.fromFirebase(String id, Map<String, dynamic> document) {
    return User(id, document['phoneNumber'], document['phoneVerified'],
        document['nic'], document['password'], document['user_type']);
  }
}
