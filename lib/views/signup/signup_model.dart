class SignupModel{
  late int id;
  late String name;
  late String username;
  late String email;
  late String phone;
  late String password;

//<editor-fold desc="Data Methods">

  SignupModel({
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  SignupModel.all({
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
      (other is SignupModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          username == other.username &&
          email == other.email &&
          phone == other.phone &&
          password == other.password);

  @override
  int get hashCode =>
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      password.hashCode;

  @override
  String toString() {
    return 'SignupModel{' +
        ' name: $name,' +
        ' username: $username,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' password: $password,' +
        '}';
  }

  String toJson() {
    return '{' +
        ' "name": "$name",' +
        ' "username": "$username",' +
        ' "email": "$email",' +
        ' "phone": "$phone",' +
        ' "password": "$password" ' +
        '}';
  }

  SignupModel copyWith({
    String? name,
    String? username,
    String? email,
    String? phone,
    String? password,
  }) {
    return SignupModel(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'username': this.username,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel.all(
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