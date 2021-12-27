import 'package:flutter/cupertino.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> _tasksList = [];

  List<Task> getTasksUsingMissionId(int missionId) =>
  _dummyTasksList.where((element) => element.missionId == missionId).toList();

  TasksProvider({required int missionId}) {
    final tasks = getTasksUsingMissionId(missionId);
    _tasksList = tasks;
  }

  List<Task> get taskList => _tasksList;

  void addTaskToList(Task value) {
    _tasksList.add(value);
    notifyListeners();
  }
}

List<Task> _dummyTasksList = [
  Task(
    taskId: 1,
    taskName: 'Task A',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),  Task(
    taskId: 1,
    taskName: 'Task B',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),  Task(
    taskId: 2,
    taskName: 'Task C',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 1,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),  Task(
    taskId: 3,
    taskName: 'Task D',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),  Task(
    taskId: 4,
    taskName: 'Task E',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),  Task(
    taskId: 5,
    taskName: 'Task F',
    createdDate: DateTime.now().toString(),
    createdBy: 'userA',
    missionId: 2,
    taskContent: 'dummyUrl',
    targetDate: 'dummyDate',
  ),
];
