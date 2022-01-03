import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/students_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/missions_screen.dart';
import 'package:mission_functionlity/screens/task_form.dart';
import 'package:mission_functionlity/utils/constants.dart';
import 'package:mission_functionlity/utils/global_methods.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

import 'add_students_option_screen.dart';

//TODO: To add functionality to assign students, let authorized people create new tasks.
class CreateTaskScreen extends StatefulWidget {
  final List<Task>? tasksList;
  final int missionId;
  const CreateTaskScreen({
    Key? key,
    required this.tasksList,
    required this.missionId,
  }) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  List<Task> tasksList = [];
  List<User> missionStudentsList = [];
  // double maxMissionWeightage = 100;

  double computeWeightageLeft([double subtractValue = 0]) {
    double sum = 0 - subtractValue;
    for (int i = 0; i < tasksList.length; i++) {
      sum += tasksList[i].taskWeightage;
    }
    return 100 - sum;
  }

  @override
  void initState() {
    super.initState();
    if (widget.tasksList != null) {
      tasksList = widget.tasksList!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double computeWeightageLeftValue = computeWeightageLeft();

    return WillPopScope(
      onWillPop: () {
        // print('POPPED');
        Navigator.pop(context, {
          "tasks": tasksList,
          "isTasksDone": computeWeightageLeftValue == 0
        });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tasks'),
        ),
        body: Container(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 25),
            itemCount: tasksList.length,
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Colors.redAccent,
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                showSnackBarWithNoAction(
                    context, 'Deleted task: ${tasksList[index].taskName}');
                setState(() {
                  tasksList.removeAt(index);
                });
              },
              child: InkWell(
                onTap: () async {
                  Task? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskForm(
                          missionId: widget.missionId,
                          weightageLeft: computeWeightageLeft(
                              tasksList[index].taskWeightage),
                          task: tasksList[index]),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      tasksList[index] = result;
                    });
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(tasksList[index].taskName),
                  // trailing: Text(
                  //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
                  subtitle: Text('Target Date: ${tasksList[index].targetDate}'),
                  trailing: Text(tasksList[index].taskWeightage.toString()),
                ),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ),
        floatingActionButton:
            // authorizedCategoriesToCreateMission
            //         .contains(Provider.of<User>(context).category.toLowerCase())?
            FloatingActionButton.extended(
          backgroundColor:
              computeWeightageLeftValue == 0 ? Colors.redAccent : null,
          onPressed: () async {
            if (computeWeightageLeftValue != 0) {
              Task? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskForm(
                          missionId: widget.missionId,
                          weightageLeft: computeWeightageLeftValue)));
              if (result != null) {
                setState(() {
                  tasksList.add(result);
                });
              }
            } else {
              Navigator.pop(context, {
                "tasks": tasksList,
                "isTasksDone": computeWeightageLeftValue == 0
              });
            }
          },
          label: Text(computeWeightageLeftValue != 0 ? 'Add Task' : 'Done'),
          icon: Icon(computeWeightageLeftValue != 0 ? Icons.add : Icons.done),
        ),
      ),
    );
  }
}
