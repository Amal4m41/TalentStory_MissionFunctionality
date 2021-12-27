import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksListProvider = Provider.of<TasksProvider>(context);
    final mission = Provider.of<Mission>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 25),
          itemCount: tasksListProvider.taskList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(tasksListProvider.taskList[index].taskName),
            // trailing: Text(
            //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
            subtitle: Text(
                'Target Date: ${tasksListProvider.taskList[index].targetDate}'),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
    );
  }
}
