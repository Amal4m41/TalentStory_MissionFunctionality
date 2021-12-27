class TaskStudentUser {
  final int taskId;
  final String studentUserName;
  final String status;
  final String taskSolution; //will store the link to the location of the file.

  TaskStudentUser({
    required this.taskId,
    required this.studentUserName,
    required this.status,
    required this.taskSolution,
  });

  TaskStudentUser.fromJson(Map<String, dynamic> json)
      : taskId = json["taskId"],
        studentUserName = json['studentUserName'],
        status = json['status'],
        taskSolution = json['taskSolution'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mission_id'] = taskId;
    data['studentUserName'] = studentUserName;
    data['status'] = status;
    data['taskSolution'] = taskSolution;
    return data;
  }
}
