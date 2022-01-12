import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_functionlity/logic/mission_api.dart';
import 'package:mission_functionlity/main.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/create_mission_form.dart';
import 'package:mission_functionlity/screens/create_task_main_screen.dart';
import 'package:mission_functionlity/screens/mission_tasks_screen.dart';
import 'package:mission_functionlity/utils/constants.dart';

class MissionsScreen extends StatefulWidget {
  const MissionsScreen({Key? key}) : super(key: key);

  @override
  State<MissionsScreen> createState() => _MissionsScreenState();
}

class _MissionsScreenState extends State<MissionsScreen> {
  late List<Mission> _missionsList;
  bool isLoading =
      false; //to display loading while the data is being fetched from the api.

  //This would be an async call later.
  List<Mission> getLatestMissionsList() => MissionApi().getAllMissions();

  @override
  void initState() {
    _missionsList = getLatestMissionsList();
  }

  @override
  Widget build(BuildContext context) {
    print('MISSION SCREEN BUILD');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission'),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 25),
          itemCount: _missionsList.length,
          itemBuilder: (context, index) {
            print("BUILD TASK ITEM $index");
            double percent = 0;
            percent = double.parse(percent.toStringAsFixed(2));
            return ListTile(
              leading: Stack(children: [
                Icon(
                  FontAwesomeIcons.trophy,
                  color: Colors.grey.shade600,
                ),
                Icon(
                  FontAwesomeIcons.trophy,
                  color: Colors.yellow.shade800.withOpacity(percent),
                ),
              ]),
              title: Text(_missionsList[index].missionName),
              // trailing: Text(
              //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
              subtitle: Text(
                  _missionsList[index].description +
                      '\nTarget date: ${_missionsList[index].targetDate}',
                  style: TextStyle(fontSize: 12)),
              trailing: Text(
                'Completed: ${percent * 100}%',
                // 'Completed: ',
                style: TextStyle(fontSize: 12),
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Text(
              //       'Completed: ',
              //       // 'Completed: ${percent * 100}%',
              //       style: TextStyle(fontSize: 12),
              //     ),
              //     LinearProgressIndicator(
              //       value: percent,
              //       color: Colors.blue,
              //       backgroundColor: Colors.grey,
              //     )
              //   ],
              // ),
              isThreeLine: true,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MissionTasksScreen(
                            mission: _missionsList[index],
                          ))),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
      floatingActionButton: authorizedCategoriesToCreateMission
              .contains(globalUser.category.toLowerCase())
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateMissionForm()));
              },
              child: const Icon(Icons.add))
          : null,
    );
  }
}
