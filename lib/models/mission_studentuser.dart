import 'package:flutter/cupertino.dart';

class MissionStudentUser {
  final int missionId;
  final String studentUserName;
  final double progressPercentage;

  MissionStudentUser({
    required this.studentUserName,
    required this.progressPercentage,
    required this.missionId,
  });

  MissionStudentUser.fromJson(Map<String, dynamic> json)
      : missionId = json["missionId"],
        studentUserName = json['studentUserName'],
        progressPercentage = json['progressPercentage'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['missionId'] = missionId;
    data['studentUserName'] = studentUserName;
    data['progressPercentage'] = progressPercentage;
    return data;
  }
}
