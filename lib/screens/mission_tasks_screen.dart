import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/task_screen.dart';
import 'package:provider/provider.dart';

class MissionTasksScreen extends StatefulWidget {
  const MissionTasksScreen({Key? key}) : super(key: key);
  @override
  State<MissionTasksScreen> createState() => _MissionTasksScreenState();
}

class _MissionTasksScreenState extends State<MissionTasksScreen> {
  late final Mission mission;

  @override
  void initState() {
    super.initState();
    mission = Provider.of<Mission>(context, listen: false);
    Provider.of<TasksProvider>(context, listen: false)
        .getTasksForMissionId(missionId: mission.missionId);
  }

  @override
  Widget build(BuildContext context) {
    print('MISSION TASKS SCREEN BUILD');

    final tasksProvider = Provider.of<TasksProvider>(context);
    final tasksList = tasksProvider.taskList;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 25),
          itemCount: tasksList.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<Task>.value(
                        value: tasksList[index], child: TaskScreen()))),
            child: ListTile(
              leading: Icon(Icons.timer),
              title: Text(tasksList[index].taskName),
              // trailing: Text(
              //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
              subtitle: Text('Target Date: ${tasksList[index].targetDate}'),
              trailing: Text(tasksList[index].taskWeightage.toString()),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }
}
