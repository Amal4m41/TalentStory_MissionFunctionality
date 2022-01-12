import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/add_students_from_class_screen.dart';
import 'package:mission_functionlity/screens/add_students_from_username_screen.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

class AddStudentsOptionScreen extends StatefulWidget {
  const AddStudentsOptionScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentsOptionScreen> createState() =>
      _AddStudentsOptionScreenState();
}

class _AddStudentsOptionScreenState extends State<AddStudentsOptionScreen> {
  // List<User> missionStudentsList = [];

  //TODO: to accept combination of students from a class and added by username(still in doubt about the feature).
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
