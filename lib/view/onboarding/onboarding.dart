import 'package:flutter/material.dart';
import 'package:task_app/view/login/login.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
/* 
3 screens 
press on "continue" button it will navigate to next screen 
*/

  Map onboardingData = {
    // list => 0 1 2 3
    'task': [
      'welcome to tasks', // 0
      'assets/images/task.png', // 1
      'tasks is awesome', // 2
      'TASK123' // 3
    ],
    'task2': [
      'task2',
      'assets/images/task2.png',
      'task2 is awesome',
      'TASK2222'
    ],
    'task3': [
      'task3',
      'assets/images/task3.png',
      'task3 is awesome',
      'TASK3333'
    ],
  };
  String currentKey = 'task';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(onboardingData[currentKey][0]),
          Image.asset(
            onboardingData[currentKey][1],
            width: 150,
            height: 150,
          ),
          Text(onboardingData[currentKey][2]),
          Text(onboardingData[currentKey][3]),
          ElevatedButton(
              onPressed: () {
                // set state
                // use .map to loop automatically
                setState(() {
                  if (currentKey == 'task') {
                    currentKey = 'task2';
                  } else if (currentKey == 'task2') {
                    currentKey = 'task3';
                  } else if (currentKey == 'task3') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => SignUpScreen()));
                  } else {
                    currentKey = 'task'; // default key
                  }
                });
              },
              child: Text("Continue"))
        ],
      ),
    );
  }
}
