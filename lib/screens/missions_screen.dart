import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/tasks_provider.dart';
import 'package:mission_functionlity/screens/mission_form.dart';
import 'package:mission_functionlity/screens/tasks_screen.dart';
import 'package:provider/provider.dart';

const authorizedCategoriesToCreateMission = ['professor', 'mentor', 'teacher'];

class MissionsScreen extends StatelessWidget {
  const MissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final missionListProvider = Provider.of<MissionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission'),
      ),
      body: Container(
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 25),
          itemCount: missionListProvider.missionList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(missionListProvider.missionList[index].missionName),
            // trailing: Text(
            //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
            subtitle: Text(missionListProvider.missionList[index].description),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MultiProvider(providers: [
                          ChangeNotifierProvider(
                            create: (BuildContext context) => TasksProvider(
                                missionId: missionListProvider
                                    .missionList[index].missionId),
                          ),
                          ChangeNotifierProvider<Mission>.value(
                            value: missionListProvider.missionList[
                                index], //mimics the signed in user.
                          ),
                        ], child: TasksScreen()))),
          ),
          separatorBuilder: (BuildContext context, int index) => Divider(),
        ),
      ),
      floatingActionButton: authorizedCategoriesToCreateMission
              .contains(Provider.of<User>(context).category.toLowerCase())
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MissionForm()));
              },
              child: const Icon(Icons.add))
          : null,
    );
  }
}
