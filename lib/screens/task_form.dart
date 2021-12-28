import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatelessWidget {
  final int missionId;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController taskWeightageController = TextEditingController();

  TaskForm({Key? key, required this.missionId}) : super(key: key);
  // String? photoUrl = null;

  // void createTask(BuildContext context, Task data) {
  //   print(data.missionId);
  //   Provider.of<TasksProvider>(context, listen: false).addTaskToList(data);
  //   showSnackBarWithNoAction(context, "Created Task successfully");
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    print("CREATE NEW TASK BUILD");
    print(missionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new task'),
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
                        return "Task name cannot be empty";
                      },
                    ),
                    addVerticalSpace(30),
                    TextFormField(
                      controller: taskWeightageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Task Weightage",
                          border: OutlineInputBorder()),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Task name cannot be empty";
                        } else if (double.parse(value) > 100) {
                          return "Task cannot have weightage > 100";
                        }
                        return null;
                      },
                    ),
                    addVerticalSpace(30),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Click to add file'),
                            addHorizontalSpace(10),
                            Icon(Icons.upload_file),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpace(40),
                    RectangularRoundButton(
                      text: "Create Task",
                      onPressedCallback: () {
                        if (_formKey.currentState!.validate()) {
                          // createTask(
                          //   context,
                          //   Task(
                          //     taskId:
                          //         tasksList[tasksList.length - 1].taskId + 1,
                          //     taskName: nameController.text,
                          //     createdDate: DateTime.now().toString(),
                          //     createdBy:
                          //         Provider.of<User>(context, listen: false)
                          //             .name,
                          //     taskContent: 'dummyURL',
                          //     targetDate: 'dummyDate',
                          //     missionId:
                          //         Provider.of<Mission>(context).missionId,
                          //     taskWeightage: 20,
                          //   ),
                          // );

                          Navigator.pop(
                            context,
                            Task(
                              taskId: Random().nextInt(200) + 1,
                              taskName: nameController.text,
                              createdDate: DateTime.now().toString(),
                              createdBy:
                                  Provider.of<User>(context, listen: false)
                                      .name,
                              taskContent: 'dummyURL',
                              targetDate: 'dummyDate',
                              missionId: missionId,
                              taskWeightage:
                                  double.parse(taskWeightageController.text),
                            ),
                          );
                        }
                      },
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
