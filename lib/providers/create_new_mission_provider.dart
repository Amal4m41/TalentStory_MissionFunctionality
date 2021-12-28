import 'package:flutter/cupertino.dart';
import 'package:mission_functionlity/models/task.dart';

class CreateNewMissionProvider extends ChangeNotifier {
  List<Task> _tasksList = [];

  List<Task> get tasksList => _tasksList;

  addTask(Task value) {
    _tasksList.add(value);
    notifyListeners();
  }

  updateTask(int index, Task value) {
    _tasksList[index] = value;
    notifyListeners();
  }
}
