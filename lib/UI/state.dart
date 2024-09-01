import 'package:task_app/Models/signupmodel.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final SignupModel user;
  UserLoaded(this.user);
}

class UserFilteredByDate extends UserState {
  final List<SignupModel> user;

  UserFilteredByDate(this.user);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}
