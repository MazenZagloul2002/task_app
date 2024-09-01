import 'package:task_app/Models/signupmodel.dart';

abstract class UserEvent {}

class LoadUser extends UserEvent {}

class SaveUser extends UserEvent {
  final SignupModel user;

  SaveUser(this.user);
}

class AddUser extends UserEvent {
  final SignupModel user;

  AddUser(this.user);
}

class FilterUserByDate extends UserEvent {
  final DateTime date;

  FilterUserByDate(this.date);
}

class UpdateUser extends UserEvent {
  final SignupModel user;

  UpdateUser(this.user);
}

class DeleteUser extends UserEvent {
  final int id;

  DeleteUser(this.id);
}
