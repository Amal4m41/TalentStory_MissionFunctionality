import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/add_students_option_screen.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

class AddStudentsMainScreen extends StatefulWidget {
  final List<User>? studentsList;
  // final int missionId;
  const AddStudentsMainScreen({
    Key? key,
    required this.studentsList,
    // required this.missionId,
  }) : super(key: key);

  @override
  State<AddStudentsMainScreen> createState() => _AddStudentsMainScreenState();
}

class _AddStudentsMainScreenState extends State<AddStudentsMainScreen> {
  List<User> _studentsList = [];

  @override
  void initState() {
    super.initState();
    if (widget.studentsList != null) {
      _studentsList = widget.studentsList!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // print('POPPED');
        Navigator.pop(context, _studentsList);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Assign Students to Mission'),
        ),
        body: Container(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 25),
            itemCount: _studentsList.length,
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Colors.redAccent,
              ),
              key: UniqueKey(),
              onDismissed: (direction) {
                showSnackBarWithNoAction(
                    context, 'Removed student: ${_studentsList[index].name}');
                setState(() {
                  _studentsList.removeAt(index);
                });
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(_studentsList[index].name),
                // trailing: Text(
                //     'Created on : ${missionListProvider.missionList[index].createdDate.split(' ')[0]}'),
                subtitle: Text('User name : ${_studentsList[index].username}'),
                trailing: Text(_studentsList[index].userClass.toString()),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ),
        floatingActionButton:
            // authorizedCategoriesToCreateMission
            //         .contains(Provider.of<User>(context).category.toLowerCase())?
            FloatingActionButton.extended(
          onPressed: () async {
            List<User>? result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddStudentsOptionScreen()));
            if (result != null) {
              setState(() {
                _studentsList = result;
              });
            }
          },
          label: const Text('Add Students'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
