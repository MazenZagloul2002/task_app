import 'package:task_app/model/usermodel/user.dart';

abstract class UserEvent {}

class SaveUser extends UserEvent {
  final UserModel usermodel;
  SaveUser(this.usermodel);
}

class LoadUser extends UserEvent {}
