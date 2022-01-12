import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/main.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

class CreateTaskForm extends StatelessWidget {
  final int missionId;
  final double weightageLeft;
  final Task?
      task; //if a task is passed, then it's for editing the details of that task.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController taskWeightageController = TextEditingController();

  CreateTaskForm({
    Key? key,
    required this.missionId,
    required this.weightageLeft,
    this.task,
  }) : super(key: key) {
    if (task != null) {
      //if a task is passed then populate the text fields with it's values.
      nameController.text = task!.taskName;
      taskWeightageController.text = task!.taskWeightage.toString();
    }
  }
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
        title: Text(task == null ? 'Create new task' : task!.taskName),
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
                          return "Task weightage cannot be empty";
                        } else if (double.parse(value) <= 0) {
                          return "Task cannot have weightage <= 0";
                        } else if (double.parse(value) > weightageLeft) {
                          return "Task cannot have weightage > ${weightageLeft}";
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
                      text: task == null ? "Create Task" : "Update Task",
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
                              createdBy: globalUser.username,
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
