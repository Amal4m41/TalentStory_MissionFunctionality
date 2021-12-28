import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/create_new_mission_provider.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/mission_form.dart';
import 'package:mission_functionlity/screens/create_task_screen.dart';
import 'package:mission_functionlity/screens/mission_tasks_screen.dart';
import 'package:mission_functionlity/utils/constants.dart';
import 'package:provider/provider.dart';

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MISSION SCREEN BUILD');
    final missionListProvider = Provider.of<MissionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission'),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 25),
          itemCount: missionListProvider.missionList.length,
          itemBuilder: (context, index) {
            print("BUILD TASK ITEM $index");
            double percent = Provider.of<TasksProvider>(context)
                .getMissionCompletedPercentage(
                    missionId:
                        missionListProvider.missionList[index].missionId);
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
              title: Text(missionListProvider.missionList[index].missionName),
              // trailing: Text(
              //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
              subtitle: Text(
                  missionListProvider.missionList[index].description +
                      '\nTarget date: ${missionListProvider.missionList[index].targetDate}',
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
                      builder: (context) => MultiProvider(providers: [
                            ChangeNotifierProvider<Mission>.value(
                              value: missionListProvider.missionList[
                                  index], //mimics the signed in user.
                            ),
                          ], child: MissionTasksScreen()))),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
      floatingActionButton: authorizedCategoriesToCreateMission
              .contains(Provider.of<User>(context).category.toLowerCase())
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) => CreateNewMissionProvider(),
                            child: MissionForm())));
              },
              child: const Icon(Icons.add))
          : null,
    );
  }
}
