class UserModel {
  late int id;
  late String name;
  late String username;
  late String email;
  late String phone;
  late String password;

//<editor-fold desc="Data Methods">

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          email == other.email &&
          phone == other.phone &&
          password == other.password);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      password.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' id: $id,' +
        ' name: $name,' +
        ' username: $username,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' password: $password,' +
        '}';
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'username': this.username,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
