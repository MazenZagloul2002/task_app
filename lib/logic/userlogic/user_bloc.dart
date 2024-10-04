import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/db/db.dart';
import 'package:task_app/logic/userlogic/user_event.dart';
import 'package:task_app/logic/userlogic/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SaveUser>(
      (event, emit) async {
        try {
          final user = await DatabaseHelper.object.queryUser();
          if (user == null) {
            await DatabaseHelper.object.insertUser(event.usermodel);
          } else {
            await DatabaseHelper.object.updateUser(event.usermodel);
          }
          final newuser = await DatabaseHelper.object.queryUser();
          if (newuser != null) {
            emit(UserLoded(newuser));
          } else {
            emit(UserError());
          }
        } catch (e) {
          print('Error during SaveUser event: $e');
          emit(UserError());
        }
      },
    );

    on<LoadUser>(
      (event, emit) async {
        try {
          final user = await DatabaseHelper.object.queryUser();
          if (user != null) {
            emit(UserLoded(user));
          } else {
            emit(UserError());
          }
        } catch (e) {
          emit(UserError());
        }
      },
    );
  }
}
