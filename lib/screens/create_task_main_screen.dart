import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/missions_screen.dart';
import 'package:mission_functionlity/screens/create_task_form.dart';
import 'package:mission_functionlity/utils/constants.dart';
import 'package:mission_functionlity/utils/global_methods.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

import 'add_students_option_screen.dart';

//Screen to view, edit, delete from the list of tasks (Before storing in db, during the creation process).
class CreateTaskMainScreen extends StatefulWidget {
  final List<Task>? tasksList;
  final int missionId;
  const CreateTaskMainScreen({
    Key? key,
    required this.tasksList,
    required this.missionId,
  }) : super(key: key);

  @override
  State<CreateTaskMainScreen> createState() => _CreateTaskMainScreenState();
}

class _CreateTaskMainScreenState extends State<CreateTaskMainScreen> {
  List<Task> _tasksList = [];
  // double maxMissionWeightage = 100;

  double computeWeightageLeft([double subtractValue = 0]) {
    double sum = 0 - subtractValue;
    for (int i = 0; i < _tasksList.length; i++) {
      sum += _tasksList[i].taskWeightage;
    }
    return 100 - sum;
  }

  @override
  void initState() {
    super.initState();
    if (widget.tasksList != null) {
      _tasksList = widget.tasksList!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double computeWeightageLeftValue = computeWeightageLeft();

    return WillPopScope(
      onWillPop: () {
        // print('POPPED');
        Navigator.pop(context, {
          "tasks": _tasksList,
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
            itemCount: _tasksList.length,
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Colors.redAccent,
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                showSnackBarWithNoAction(
                    context, 'Deleted task: ${_tasksList[index].taskName}');
                setState(() {
                  _tasksList.removeAt(index);
                });
              },
              child: InkWell(
                onTap: () async {
                  Task? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTaskForm(
                          missionId: widget.missionId,
                          weightageLeft: computeWeightageLeft(
                              _tasksList[index].taskWeightage),
                          task: _tasksList[index]),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      _tasksList[index] = result;
                    });
                  }
                },
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(_tasksList[index].taskName),
                  // trailing: Text(
                  //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
                  subtitle:
                      Text('Target Date: ${_tasksList[index].targetDate}'),
                  trailing: Text(_tasksList[index].taskWeightage.toString()),
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
                      builder: (context) => CreateTaskForm(
                          missionId: widget.missionId,
                          weightageLeft: computeWeightageLeftValue)));
              if (result != null) {
                setState(() {
                  _tasksList.add(result);
                });
              }
            } else {
              Navigator.pop(context, {
                "tasks": _tasksList,
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
