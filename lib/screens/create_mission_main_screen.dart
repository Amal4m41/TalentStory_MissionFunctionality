import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/students_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/add_students_main_screen.dart';
import 'package:mission_functionlity/utils/global_methods.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

import 'add_students_option_screen.dart';
import 'create_task_screen.dart';
import 'missions_screen.dart';

class CreateMissionMainScreen extends StatefulWidget {
  final List<Task>? taskList;
  final List<User>? studentsList;
  final bool? isTasksDone;

  const CreateMissionMainScreen({
    Key? key,
    required this.studentsList,
    required this.taskList,
    required this.isTasksDone,
  }) : super(key: key);

  @override
  State<CreateMissionMainScreen> createState() =>
      _CreateMissionMainScreenState();
}

class _CreateMissionMainScreenState extends State<CreateMissionMainScreen> {
  List<Task> _tasksList = [];
  bool _isTasksDone = false;
  List<User> _studentsList = [];

  void createNewMission({required Mission mission}) {
    if (_tasksList.isNotEmpty) {
      if (_studentsList.isEmpty) {
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
          for (var i in _studentsList) {
            missionStudents.add(MissionStudentUser(
                studentUserName: i.username, missionId: mission.missionId));
            print(i.username);
          }
          Provider.of<StudentsProvider>(context, listen: false)
              .addMissionStudentUsers(missionStudents);

          //Add tasks for the mission.
          for (var i in _tasksList) {
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
      showSnackBarWithNoAction(context, 'Tasks cannot be empty', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.studentsList != null) {
      _studentsList = widget.studentsList!;
    }
    if (widget.taskList != null) {
      _tasksList = widget.taskList!;
    }
    if (widget.isTasksDone != null) {
      _isTasksDone = widget.isTasksDone!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mission = Provider.of<Mission>(context);
    print(mission.missionId);
    return WillPopScope(
      onWillPop: () {
        // print('POPPED');
        Navigator.pop(context, {
          "tasks": _tasksList,
          "students": _studentsList,
          "isTasksDone": _isTasksDone,
        });
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Mission"),
          actions:
              _tasksList.isNotEmpty && _studentsList.isNotEmpty && _isTasksDone
                  ? [
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
                    ]
                  : null,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                onPressed: () async {
                  Map<String, dynamic>? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTaskScreen(
                          tasksList: _tasksList, missionId: mission.missionId),
                    ),
                  );

                  if (result != null) {
                    _tasksList = result["tasks"] as List<Task>;
                    _isTasksDone = result["isTasksDone"];
                    setState(() {});
                  }
                  print(_tasksList);
                  print(_isTasksDone);
                },
                child: _tasksList.isNotEmpty
                    ? Badge(
                        position: BadgePosition(top: -35, end: -60),
                        shape: BadgeShape.square,
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: _tasksList.isNotEmpty
                            ? Text(
                                _isTasksDone ? 'Completed' : 'Incomplete',
                                style: const TextStyle(color: Colors.white),
                              )
                            : null,
                        badgeColor:
                            _isTasksDone ? Colors.green : Colors.redAccent,
                        child: const Text("Edit Tasks",
                            style: TextStyle(color: Colors.white)),
                      )
                    : const Text(
                        "Create Tasks",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  ),
                  onPressed: _isTasksDone
                      ? () async {
                          List<User>? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddStudentsMainScreen(
                                      studentsList: _studentsList)));
                          if (result != null) {
                            _studentsList = result;
                            setState(() {});
                          }
                          print(_studentsList);
                        }
                      : null, //diable button to add students until the tasks are created.
                  child: const Text(
                    "Add Students",
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
