import 'package:flutter/cupertino.dart';
import 'package:mission_functionlity/models/mission_studentuser.dart';
import 'package:mission_functionlity/models/user.dart';

class StudentsProvider with ChangeNotifier {}

List<User> studentsData = [
  User(username: 'Messi123', name: 'Messi', category: 'student'),
  User(username: 'Neymari123', name: 'Neymar', category: 'student'),
  User(username: 'Ronaldo123', name: 'Ronaldo', category: 'student'),
  User(username: 'Kane123', name: 'Kane', category: 'student'),
  User(username: 'Pajanic123', name: 'Pajanic', category: 'student'),
];

List<MissionStudentUser> missionStudentData = [
  MissionStudentUser(studentUserName: 'Messi123', missionId: 1),
  MissionStudentUser(studentUserName: 'Messi123', missionId: 1),
  MissionStudentUser(studentUserName: 'Messi123', missionId: 1),
  MissionStudentUser(studentUserName: 'Messi123', missionId: 2),
  MissionStudentUser(studentUserName: 'Messi123', missionId: 2),
];
