import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/Models/signupmodel.dart';
import 'package:task_app/UI/bloc.dart';
import 'package:task_app/UI/state.dart';
import 'event.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  final newTodo = SignupModel(
                    username: _titleController.text,
                    password: _descriptionController.text,
                  );
                  log(newTodo.id.toString());

                  context.read<UserBloc>().add(AddUser(newTodo));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  get user => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final SignupModel = state.user;
            return ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final SignupModel = user[index];
                return Column(
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(SignupModel.username),
                          Text(SignupModel.password),
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('No todos yet'));
          }
        },
      ),
    );
  }
}
