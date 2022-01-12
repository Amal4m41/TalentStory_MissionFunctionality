import 'package:mission_functionlity/models/task.dart';

class MissionTasksApi {
  // void waitFunction(int seconds) async {
  //   await Future.delayed(Duration(seconds: seconds));
  //   notifyListeners();
  // }

  List<Task> _getTasksUsingMissionId(int missionId) => _globalTasksList
      .where((element) => element.missionId == missionId)
      .toList();

  List<Task> getTasksForMissionId({required int missionId}) {
    return _getTasksUsingMissionId(missionId);
    // waitFunction(1);
  }

  double getMissionCompletedPercentage({required int missionId}) {
    final tasks = _getTasksUsingMissionId(missionId);
    double sum = 0;
    for (var element in tasks) {
      sum += element.taskWeightage;
    }
    return sum / 100;
  }

  void createTasks(List<Task> tasks) {
    for (Task i in tasks) {
      _globalTasksList.add(i);
    }
  }
}

//Mimics the tasks table in the database.
List<Task> _globalTasksList = [
  Task(
    taskId: 1,
    taskName: 'Task A',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 20,
  ),
  Task(
    taskId: 9,
    taskName: 'Task B',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 20,
  ),
  Task(
    taskId: 2,
    taskName: 'Task C',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 60,
  ),
  Task(
    taskId: 3,
    taskName: 'Task D',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 50,
  ),
  Task(
    taskId: 4,
    taskName: 'Task E',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 20,
  ),
  Task(
    taskId: 5,
    taskName: 'Task F',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
    taskWeightage: 30,
  ),
];
