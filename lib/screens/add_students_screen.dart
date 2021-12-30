import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/students_provider.dart';
import 'package:mission_functionlity/screens/add_students_from_class_screen.dart';
import 'package:mission_functionlity/screens/add_students_from_username_screen.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

class AddStudentsScreen extends StatefulWidget {
  const AddStudentsScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentsScreen> createState() => _AddStudentsScreenState();
}

class _AddStudentsScreenState extends State<AddStudentsScreen> {
  // List<User> missionStudentsList = [];

  //TODO: to accept combination of students from a class and added by username.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Students'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RectangularRoundButton(
              text: "Add Students from Class",
              onPressedCallback: () async {
                List<User>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddStudentsFromClass(),
                  ),
                );
                if (result != null) {
                  print(result);
                  Navigator.pop(context, result);
                }
              },
            ),
            addVerticalSpace(40),
            RectangularRoundButton(
              text: "Add Students using Username",
              onPressedCallback: () async {
                List<User>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddStudentsFromUsernameScreen(),
                  ),
                );
                if (result != null) {
                  print(result);
                  Navigator.pop(context, result);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
