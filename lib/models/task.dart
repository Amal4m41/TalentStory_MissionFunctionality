class Task {
  final int taskId;
  final String taskName;
  final String createdDate;
  final String
      createdBy; //will store the id of the user(user with category = mentor/professor/teacher)
  final int missionId;
  final String taskContent; //will store the link to the doc stored location.
  final String targetDate;

  Task({
    required this.taskId,
    required this.taskName,
    required this.createdDate,
    required this.createdBy,
    required this.missionId,
    required this.taskContent,
    required this.targetDate,
  });

  Task.fromJson(Map<String, dynamic> json)
      : taskId = json["taskId"],
        taskName = json['taskName'],
        createdDate = json['createdDate'],
        createdBy = json['createdBy'],
        missionId = json['missionId'],
        taskContent = json['taskContent'],
        targetDate = json['targetDate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['taskId'] = taskId;
    data['taskName'] = taskName;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['missionId'] = missionId;
    data['taskContent'] = taskContent;
    data['targetDate'] = targetDate;
    return data;
  }
}
