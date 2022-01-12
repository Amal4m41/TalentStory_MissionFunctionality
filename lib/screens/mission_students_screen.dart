import 'package:flutter/material.dart';
import 'package:mission_functionlity/logic/mission_students_api.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:provider/provider.dart';

class MissionStudentsScreen extends StatefulWidget {
  final int missionId;
  const MissionStudentsScreen({Key? key, required this.missionId, mission})
      : super(key: key);

  @override
  State<MissionStudentsScreen> createState() => _MissionStudentsScreenState();
}

class _MissionStudentsScreenState extends State<MissionStudentsScreen> {
  List<User> _studentsList = [];

  @override
  void initState() {
    super.initState();
    print(widget.missionId);
    _studentsList =
        MissionStudentsApi().getStudentsListUsingMissionId(widget.missionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Assigned'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _studentsList.length,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.person),
            title: Text(_studentsList[index].name),
            subtitle: Text(
                'Username: ${_studentsList[index].username}\nClass: ${_studentsList[index].userClass.toString()}'),
            isThreeLine: true,
            trailing:
                Text("0%"), //static text for the progress of each student.
          ),
        ),
      ),
    );
  }
}
