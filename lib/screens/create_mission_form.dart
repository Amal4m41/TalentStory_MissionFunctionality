import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/main.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/create_mission_main_screen.dart';
import 'package:mission_functionlity/screens/create_task_form.dart';
import 'package:mission_functionlity/screens/create_task_main_screen.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class CreateMissionForm extends StatefulWidget {
  @override
  State<CreateMissionForm> createState() => _CreateMissionFormState();
}

class _CreateMissionFormState extends State<CreateMissionForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final int _missionId =
      Random().nextInt(1000) + 10; //generate a random missionId.

  //To maintain the state of students assigned and tasks created even if the user switches back till this screen.
  List<Task>? _tasksList;
  List<User>? _studentsList;
  bool _isTasksDone = false; //to track if the tasks weightage sum == 100.

  @override
  Widget build(BuildContext context) {
    print("CREATE USER PROFILE BUILD");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new mission'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          child: Column(
            children: [
              addVerticalSpace(10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: "Name", border: OutlineInputBorder()),
                      validator: (String? value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        }
                        return "Mission name cannot be empty";
                      },
                    ),
                    addVerticalSpace(40),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder()),
                      validator: (String? value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        }
                        return "Mission description cannot be empty";
                      },
                    ),
                    addVerticalSpace(40),
                    RectangularRoundButton(
                        text: "Next",
                        onPressedCallback: () async {
                          Map<String, dynamic>? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateMissionMainScreen(
                                mission: Mission(
                                  missionId: _missionId,
                                  missionName: nameController.text,
                                  createdDate: DateTime.now().toString(),
                                  createdBy: globalUser.name,
                                  description: descriptionController.text,
                                  targetDate: 'dummyDate',
                                ),
                                studentsList: _studentsList,
                                taskList: _tasksList,
                                isTasksDone: _isTasksDone,
                              ),
                            ),
                          );

                          if (result != null) {
                            _tasksList = result["tasks"] as List<Task>?;
                            _studentsList = result["students"] as List<User>?;
                            _isTasksDone = result["isTasksDone"];
                            print(_isTasksDone);
                          }
                        }
                        // onPressedCallback: () async {
                        //   if (_formKey.currentState!.validate()) {
                        //     final missionList = Provider.of<MissionProvider>(
                        //             context,
                        //             listen: false)
                        //         .missionList;
                        //     // createMission(
                        //     //   context,
                        //     //   Mission(
                        //     //     missionId: missionList[missionList.length - 1]
                        //     //             .missionId +
                        //     //         1,
                        //     //     missionName: nameController.text,
                        //     //     createdDate: DateTime.now().toString(),
                        //     //     createdBy:
                        //     //         Provider.of<User>(context, listen: false)
                        //     //             .name,
                        //     //     description: descriptionController.text,
                        //     //     targetDate: 'dummyDate',
                        //     //   ),
                        //     // );
                        //
                        //     tasksList = await Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) =>
                        //             ChangeNotifierProvider.value(
                        //           value: Mission(
                        //             missionId: missionList[missionList.length - 1]
                        //                     .missionId +
                        //                 1,
                        //             missionName: nameController.text,
                        //             createdDate: DateTime.now().toString(),
                        //             createdBy:
                        //                 Provider.of<User>(context, listen: false)
                        //                     .name,
                        //             description: descriptionController.text,
                        //             targetDate: 'dummyDate',
                        //           ),
                        //           child: CreateTaskScreen(
                        //             tasksList: tasksList,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   }
                        // },
                        )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
