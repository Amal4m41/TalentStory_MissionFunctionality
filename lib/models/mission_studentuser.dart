import 'package:flutter/cupertino.dart';

class MissionStudentUser {
  final int missionId;
  final String studentUserName;

  MissionStudentUser({
    required this.studentUserName,
    required this.missionId,
  });

  MissionStudentUser.fromJson(Map<String, dynamic> json)
      : missionId = json["missionId"],
        studentUserName = json['studentUserName'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['missionId'] = missionId;
    data['studentUserName'] = studentUserName;
    return data;
  }
}
