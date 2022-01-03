import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/providers/students_provider.dart';
import 'package:provider/provider.dart';

class MissionStudentsScreen extends StatefulWidget {
  final int missionId;
  MissionStudentsScreen({Key? key, required this.missionId, mission})
      : super(key: key);

  @override
  State<MissionStudentsScreen> createState() => _MissionStudentsScreenState();
}

class _MissionStudentsScreenState extends State<MissionStudentsScreen> {
  List<User> studentsList = [];

  @override
  void initState() {
    super.initState();
    print(widget.missionId);
    studentsList = Provider.of<StudentsProvider>(context, listen: false)
        .getStudentsListUsingMissionId(widget.missionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Assigned'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: studentsList.length,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.person),
            title: Text(studentsList[index].name),
            subtitle: Text(
                'Username: ${studentsList[index].username}\nClass: ${studentsList[index].userClass.toString()}'),
            isThreeLine: true,
            trailing:
                Text("0%"), //static text for the progress of each student.
          ),
        ),
      ),
    );
  }
}
