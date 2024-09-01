import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Models/signupmodel.dart';
import 'package:task_app/UI/DBheiper.dart';
import 'package:task_app/UI/event.dart';
import 'package:task_app/UI/state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<SaveUser>(
      (event, emit) async {
        try {
          var currentUser = await DatabaseHelper.dbInstance.queryUser();
          if (currentUser == null) {
            DatabaseHelper.dbInstance.insert(event.user);
          } else {
            final updateUser = SignupModel(
                username: event.user.username, password: event.user.password);
            await DatabaseHelper.dbInstance.update(updateUser);
            emit(UserLoaded(event.user));
          }
        } catch (e) {
          emit(UserError(e.toString()));
        }
      },
    );
    on<LoadUser>(
      (event, emit) async {
        try {
          final userLoad = await DatabaseHelper.dbInstance.queryUser();
          if (userLoad == null) {
            emit(UserError("No tasks available"));
          } else {
            emit(UserLoaded(userLoad));
          }
        } catch (e) {
          emit(UserError(e.toString()));
        }
      },
    );

    on<AddUser>((event, emit) async {
      await db.create(event.user);
      add(LoadUser());
    });

    on<UpdateUser>((event, emit) async {
      await db.update(event.user);
      add(LoadUser());
    });

    on<FilterUserByDate>((event, emit) async {
      emit(UserLoading());
      try {
        final todos = await db.readAllUser();
        final filteredTodos = todos.where((todo) {
          return todo.date.year == event.date.year &&
              todo.date.month == event.date.month &&
              todo.date.day == event.date.day;
        }).toList();
        if (filteredTodos.isEmpty) {
          emit(UserError("No tasks available"));
        } else {
          emit(UserFilteredByDate(filteredTodos));
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }

  get db => null;
}
