import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/missions_screen.dart';
import 'package:mission_functionlity/screens/task_form.dart';
import 'package:mission_functionlity/utils/constants.dart';
import 'package:mission_functionlity/utils/global_methods.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

//TODO: To add functionality to assign students, let authorized people create new tasks.
class CreateTaskScreen extends StatefulWidget {
  final List<Task>? tasksList;
  const CreateTaskScreen({Key? key, required this.tasksList}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  List<Task> tasksList = [];
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
                      double sumOfTaskWeightage = 0;
                      for (var task in tasksList) {
                        sumOfTaskWeightage += task.taskWeightage;
                      }
                      if (sumOfTaskWeightage == 100) {
                        GlobalMethods().showDialogBox(
                          context: context,
                          title: 'Create Mission',
                          subtitle:
                              'Once created, the Mission or it\'s Tasks cannot be edited.',
                          onPressedTrue: () {
                            Provider.of<MissionProvider>(context, listen: false)
                                .addMissionToList(mission);
                            for (var i in tasksList) {
                              Provider.of<TasksProvider>(context, listen: false)
                                  .addTaskToList(i);
                              //TODO: use pop until
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MissionsScreen()),
                                  (route) => route.isFirst);
                            }
                          },
                          onPressedFalse: () {},
                        );
                      } else {
                        showSnackBarWithNoAction(
                            context,
                            'Tasks Weightage should sum up to 100!',
                            Colors.red);
                      }
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
        floatingActionButton: authorizedCategoriesToCreateMission
                .contains(Provider.of<User>(context).category.toLowerCase())
            ? FloatingActionButton.extended(
                onPressed: () async {
                  Task? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskForm(
                              missionId: mission.missionId,
                              weightageLeft: computeWeightageLeft())));
                  if (result != null) {
                    setState(() {
                      tasksList.add(result);
                    });
                  }
                },
                label: Text('Add Task'),
                icon: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}
