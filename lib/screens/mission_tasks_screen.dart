import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/logic/mission_tasks_api.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';
import 'package:mission_functionlity/screens/task_content_screen.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

import 'mission_students_screen.dart';

class MissionTasksScreen extends StatefulWidget {
  final Mission mission;
  const MissionTasksScreen({Key? key, required this.mission}) : super(key: key);
  @override
  State<MissionTasksScreen> createState() => _MissionTasksScreenState();
}

class _MissionTasksScreenState extends State<MissionTasksScreen> {
  late List<Task> _tasksList;

  @override
  void initState() {
    super.initState();
    _tasksList = MissionTasksApi()
        .getTasksForMissionId(missionId: widget.mission.missionId);
  }

  @override
  Widget build(BuildContext context) {
    print('MISSION TASKS SCREEN BUILD');

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 25),
                itemCount: _tasksList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<Task>.value(
                                  value: _tasksList[index],
                                  child: TaskContentScreen()))),
                  child: ListTile(
                    leading: Icon(Icons.timer),
                    title: Text(_tasksList[index].taskName),
                    // trailing: Text(
                    //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
                    subtitle:
                        Text('Target Date: ${_tasksList[index].targetDate}'),
                    trailing: Text(_tasksList[index].taskWeightage.toString()),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
            RectangularRoundButton(
              text: 'See assigned students',
              onPressedCallback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MissionStudentsScreen(
                            missionId: widget.mission.missionId)));
              },
            ),
            addVerticalSpace(20),
          ],
        ),
      ),
    );
  }
}
