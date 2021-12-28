import 'package:flutter/cupertino.dart';
import 'package:mission_functionlity/models/mission.dart';

class MissionProvider extends ChangeNotifier {
  List<Mission> _missionList = [];

  MissionProvider() {
    _missionList = [
      Mission(
        missionId: 1,
        missionName: 'ABC',
        createdDate: DateTime.now().toString(),
        createdBy: 'user1',
        description: 'A demo mission',
        targetDate: 'dummyDate',
      ),
      Mission(
          missionId: 2,
          missionName: 'EFG',
          createdDate: DateTime.now().toString(),
          createdBy: 'user2',
          targetDate: 'dummyDate',
          description: 'A demo mission'),
      Mission(
          missionId: 3,
          missionName: 'XYZ',
          createdDate: DateTime.now().toString(),
          createdBy: 'user3',
          targetDate: 'dummyDate',
          description: 'A demo mission'),
      Mission(
          missionId: 4,
          missionName: 'PQR',
          createdDate: DateTime.now().toString(),
          createdBy: 'user4',
          targetDate: 'dummyDate',
          description: 'A demo mission'),
    ];
  }

  List<Mission> get missionList => _missionList;

  void addMissionToList(Mission value) {
    _missionList.add(value);
    notifyListeners();
  }
}
