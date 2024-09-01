class SignupModel {
  final int? id;
  final String? username;
  final String? password;
  SignupModel({this.id, required this.username, required this.password});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }
}
