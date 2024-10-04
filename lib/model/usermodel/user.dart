class UserModel {
  // create the variables
  int? id;
  String username;
  String pass;
  // call the variables in the constructor
  UserModel({this.id, required this.username, required this.pass});
  // convert the variables to database
  Map<String, dynamic> tomap() {
    return {'username': username, 'pass': pass};
  }

// return variables from db
  factory UserModel.fromMap(Map<String, dynamic> fromMap) {
    return UserModel(
        username: fromMap['username'],
        pass: fromMap['pass'],
        id: fromMap['id']);
  }
}
