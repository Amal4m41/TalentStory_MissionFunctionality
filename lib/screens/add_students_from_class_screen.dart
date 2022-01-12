import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/logic/mission_students_api.dart';
import 'package:mission_functionlity/main.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class AddStudentsFromClass extends StatefulWidget {
  const AddStudentsFromClass({Key? key}) : super(key: key);

  @override
  State<AddStudentsFromClass> createState() => _AddStudentsFromClassState();
}

class _AddStudentsFromClassState extends State<AddStudentsFromClass> {
  List<User> classStudentsList = [];
  final studentClassController = TextEditingController();
  bool isShowStudentsList = false;

  List<User> getClassStudentsList(int classValue) {
    return MissionStudentsApi().getClassStudentsList(classValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(globalUser.schoolName)),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Enter class : '),
                Expanded(
                  child: TextField(
                    controller: studentClassController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            addVerticalSpace(40),
            RectangularRoundButton(
              text: 'Select',
              onPressedCallback: () {
                final int classValue = int.parse(studentClassController.text);
                if (classValue > 12 || classValue < 1) {
                  showSnackBarWithNoAction(
                      context, 'Invalid Class Value !', Colors.redAccent);
                  isShowStudentsList = false;
                  setState(() {});
                } else {
                  classStudentsList = getClassStudentsList(classValue);
                  isShowStudentsList = true;
                  setState(() {});
                }
              },
            ),
            addVerticalSpace(30),
            isShowStudentsList
                ? classStudentsList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: classStudentsList.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(classStudentsList[index].name),
                                  subtitle: Text(
                                      'Username: ${classStudentsList[index].username}'),
                                  trailing: Text(classStudentsList[index]
                                      .userClass
                                      .toString()),
                                )),
                      )
                    : Center(child: Text('Empty Students List'))
                : addVerticalSpace(0),
            isShowStudentsList && classStudentsList.isNotEmpty
                ? RectangularRoundButton(
                    text: 'Add Students',
                    onPressedCallback: () {
                      Navigator.pop(context, classStudentsList);
                    },
                  )
                : addVerticalSpace(0),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}
