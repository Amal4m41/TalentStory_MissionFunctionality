import 'package:flutter/cupertino.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/user.dart';

class StudentsProvider with ChangeNotifier {
  List<MissionStudentUser> _missionStudentsListData = [];
  List<User> _studentsListData = [];

  StudentsProvider() {
    _missionStudentsListData = missionStudentData;
    _studentsListData = studentsData;
  }

  get missionStudentsListData => _missionStudentsListData;
  get studentsListData => _studentsListData;

  void addMissionStudentUsers(List<MissionStudentUser> students) {
    for (int i = 0; i < students.length; i++) {
      _missionStudentsListData.add(students[i]);
    }

    notifyListeners();
  }

  List<User> getStudentsListUsingMissionId(int missionId) {
    List<MissionStudentUser> missionStudents =
        _missionStudentsListData.where((element) {
      return element.missionId == missionId;
    }).toList();

    for (int i = 0; i < missionStudents.length; i++) {
      print(missionStudents[i]);
    }

    List<User> result = [];
    for (int i = 0; i < missionStudents.length; i++) {
      for (int j = 0; j < _studentsListData.length; j++) {
        if (missionStudents[i].studentUserName ==
            _studentsListData[j].username) {
          result.add(_studentsListData[j]);
        }
      }
    }
    // missionStudents.forEach((element) {
    //   print(element.studentUserName);
    // });
    return result;
  }
}

List<User> studentsData = [
  User(
      username: 'Messi123',
      name: 'Messi',
      category: 'student',
      schoolName: 'ABC',
      userClass: 10),
  User(
      username: 'Maradona10',
      name: 'Maradona',
      category: 'student',
      schoolName: 'ABC',
      userClass: 10),
  User(
      username: 'Neymari123',
      name: 'Neymar',
      category: 'student',
      schoolName: 'ABC',
      userClass: 9),
  User(
      username: 'Ronaldo123',
      name: 'Ronaldo',
      category: 'student',
      schoolName: 'ABC',
      userClass: 10),
  User(
      username: 'Kane123',
      name: 'Kane',
      category: 'student',
      schoolName: 'ABC',
      userClass: 9),
  User(
      username: 'Pajanic123',
      name: 'Pajanic',
      category: 'student',
      schoolName: 'ABC',
      userClass: 9),
  User(
      username: 'Zlatan52',
      name: 'Zlatan',
      category: 'student',
      schoolName: 'ABC',
      userClass: 10),
];

List<MissionStudentUser> missionStudentData = [
  MissionStudentUser(studentUserName: 'Messi123', missionId: 1),
  MissionStudentUser(studentUserName: 'Neymari123', missionId: 1),
  MissionStudentUser(studentUserName: 'Zlatan52', missionId: 1),
  MissionStudentUser(studentUserName: 'Pajanic123', missionId: 2),
  MissionStudentUser(studentUserName: 'Ronaldo123', missionId: 2),
];
