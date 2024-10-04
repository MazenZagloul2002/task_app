import 'package:task_app/model/usermodel/user.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoded extends UserState {
  final UserModel userModelState;
  UserLoded(this.userModelState);
}

class UserError extends UserState {}
