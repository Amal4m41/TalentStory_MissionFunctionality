import 'package:flutter/cupertino.dart';

class Mission with ChangeNotifier {
  final int missionId;
  final String missionName;
  final String createdDate;
  final String
      createdBy; //will store the id of the user(user with category = mentor/professor/teacher)
  final String description;
  final String
      targetDate; //expected date of completion for the mission(i.e. all the tasks)
  //add  trailing(percentage) and target date() for each mission.

  Mission({
    required this.missionId,
    required this.missionName,
    required this.createdDate,
    required this.createdBy,
    required this.description,
    required this.targetDate,
  });

  Mission.fromJson(Map<String, dynamic> json)
      : missionId = json["missionId"],
        missionName = json['missionName'],
        createdDate = json['createdDate'],
        createdBy = json['createdBy'],
        description = json['description'],
        targetDate = json['targetDate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['missionId'] = missionId;
    data['missionName'] = missionName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['description'] = description;
    data['targetDate'] = targetDate;
    return data;
  }
}
