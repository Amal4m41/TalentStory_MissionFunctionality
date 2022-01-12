import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/user.dart';

import '../main.dart';

class MissionStudentsApi {
  void addMissionStudentUsers(List<MissionStudentUser> students) {
    for (int i = 0; i < students.length; i++) {
      _globalMissionStudentData.add(students[i]);
    }
  }

  List<User> get getAllStudents => _globalStudentsData;

  List<User> getClassStudentsList(int classValue) {
    return _globalStudentsData
        .where((student) =>
            student.schoolName == globalUser.schoolName &&
            student.userClass == classValue)
        .toList();
  }

  List<User> getStudentsListUsingMissionId(int missionId) {
    List<MissionStudentUser> missionStudents =
        _globalMissionStudentData.where((element) {
      return element.missionId == missionId;
    }).toList();

    // for (int i = 0; i < missionStudents.length; i++) {
    //   print(missionStudents[i]);
    // }

    List<User> result = [];
    for (int i = 0; i < missionStudents.length; i++) {
      for (int j = 0; j < _globalStudentsData.length; j++) {
        if (missionStudents[i].studentUserName ==
            _globalStudentsData[j].username) {
          result.add(_globalStudentsData[j]);
        }
      }
    }
    // missionStudents.forEach((element) {
    //   print(element.studentUserName);
    // });
    return result;
  }
}

//Mimics the user table(filtered as category = student) in the database.
List<User> _globalStudentsData = [
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

List<MissionStudentUser> _globalMissionStudentData = [
  MissionStudentUser(studentUserName: 'Messi123', missionId: 1),
  MissionStudentUser(studentUserName: 'Neymari123', missionId: 1),
  MissionStudentUser(studentUserName: 'Zlatan52', missionId: 1),
  MissionStudentUser(studentUserName: 'Pajanic123', missionId: 2),
  MissionStudentUser(studentUserName: 'Ronaldo123', missionId: 2),
];
