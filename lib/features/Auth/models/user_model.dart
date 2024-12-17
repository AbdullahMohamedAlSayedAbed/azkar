class UserModel {
  final String email;
  final String password;
  final double age;
  final String gender;
  final String status;

  UserModel({
    required this.email,
    required this.password,
    required this.age,
    required this.gender,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'],
      password: map['password'],
      age: map['age'],
      gender: map['gender'],
      status: map['status'],
    );
  }
}
