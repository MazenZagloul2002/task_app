import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/logic/userlogic/user_bloc.dart';
import 'package:task_app/logic/userlogic/user_event.dart';
import 'package:task_app/logic/userlogic/user_state.dart';
import 'package:task_app/model/usermodel/user.dart';
import 'package:task_app/view/home/home.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final user = UserModel(
                  username: usernameController.text,
                  pass: passwordController.text,
                );
                context.read<UserBloc>().add(SaveUser(user));

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const HomeScreen123()));
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen123 extends StatelessWidget {
  const HomeScreen123({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(LoadUser());

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoded) {
            return Center(
                child: Text('Welcome, ${state.userModelState.username}'));
          } else if (state is UserError) {
            return Center(child: Text('Error loading user'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (builder) => ProfileScreen())),
        child: Icon(Icons.edit),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Home()));
              },
              icon: Icon(Icons.navigate_next))
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoded) {
            _usernameController.text = state.userModelState.username;
            _passwordController.text = state.userModelState.pass;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final updatedUser = UserModel(
                        id: state.userModelState
                            .id, // Use the ID of the existing user
                        username: _usernameController.text,
                        pass: _passwordController.text,
                      );
                      context.read<UserBloc>().add(SaveUser(updatedUser));
                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                  ),
                ],
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text('Error loading user'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
