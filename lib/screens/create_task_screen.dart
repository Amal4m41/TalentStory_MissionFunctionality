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

import 'add_students_screen.dart';

//TODO: To add functionality to assign students, let authorized people create new tasks.
class CreateTaskScreen extends StatefulWidget {
  final List<Task>? tasksList;
  const CreateTaskScreen({Key? key, required this.tasksList}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  List<Task> tasksList = [];
  List<User> missionStudentsList = [];
  // double maxMissionWeightage = 100;

  void createNewMission({required Mission mission}) {
    if (computeWeightageLeft() == 0) {
      if (missionStudentsList.isEmpty) {
        showSnackBarWithNoAction(context,
            'Please assign student(s) to create a Mission', Colors.red);
        return;
      }
      GlobalMethods().showDialogBox(
        context: context,
        title: 'Create Mission',
        subtitle: 'Once created, the Mission or it\'s Tasks cannot be edited.',
        onPressedTrue: () {
          //Add the mission
          Provider.of<MissionProvider>(context, listen: false)
              .addMissionToList(mission);

          //Add students for the mission
          List<MissionStudentUser> missionStudents = [];
          for (var i in missionStudentsList) {
            missionStudents.add(MissionStudentUser(
                studentUserName: i.username, missionId: mission.missionId));
            print(i.username);
          }
          Provider.of<StudentsProvider>(context, listen: false)
              .addMissionStudentUsers(missionStudents);

          //Add tasks for the mission.
          for (var i in tasksList) {
            Provider.of<TasksProvider>(context, listen: false).addTaskToList(i);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MissionsScreen()),
                (route) => route.isFirst);
          }
        },
        onPressedFalse: () {},
      );
    } else {
      showSnackBarWithNoAction(
          context, 'Tasks Weightage should sum up to 100!', Colors.red);
    }
  }

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
    final mission = Provider.of<Mission>(context);
    print(mission.missionId);
    return WillPopScope(
      onWillPop: () {
        // print('POPPED');
        Navigator.pop(context, tasksList);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tasks'),
          actions: tasksList.isEmpty
              ? null
              : [
                  InkWell(
                    onTap: () {
                      createNewMission(mission: mission);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'Create Mission',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  )
                ],
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
                          missionId: mission.missionId,
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
                          missionId: mission.missionId,
                          weightageLeft: computeWeightageLeftValue)));
              if (result != null) {
                setState(() {
                  tasksList.add(result);
                });
              }
            } else {
              List<User>? result = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStudentsScreen()));
              if (result != null) {
                missionStudentsList = result;
              }
            }
          },
          label: Text(
              computeWeightageLeftValue != 0 ? 'Add Task' : 'Add Students'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
