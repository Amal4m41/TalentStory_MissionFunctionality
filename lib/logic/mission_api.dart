import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/task.dart';

//The functionalities below will be updated with API calls, once the APIs are ready.
class MissionApi {
  createMission(Mission value) {
    _globalMissionsList.add(value);
  }

  // getMission(missionId){
  //
  // }

  getAllMissions() {
    return _globalMissionsList;
  }
}

//Mimics the missions table in the database.
List<Mission> _globalMissionsList = [
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
