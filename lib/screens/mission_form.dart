import 'package:flutter/material.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/models/mission.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/providers/mission_provider.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class MissionForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // String? photoUrl = null;

  void createMission(BuildContext context, Mission data) {
    print('data');
    print(data);
    print(data.missionId);
    Provider.of<MissionProvider>(context, listen: false).addMissionToList(data);
    showSnackBarWithNoAction(context, "Created Mission successfully");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("CREATE USER PROFILE BUILD");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new mission'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
          child: Column(
            children: [
              addVerticalSpace(10),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          labelText: "Name", border: OutlineInputBorder()),
                      validator: (String? value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        }
                        return "Mission name cannot be empty";
                      },
                    ),
                    addVerticalSpace(40),
                    TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder()),
                      validator: (String? value) {
                        if (value != null && value.trim().isNotEmpty) {
                          return null;
                        }
                        return "Mission description cannot be empty";
                      },
                    ),
                    addVerticalSpace(40),
                    RectangularRoundButton(
                      text: "Create Mission",
                      onPressedCallback: () {
                        if (_formKey.currentState!.validate()) {
                          final missionList = Provider.of<MissionProvider>(
                                  context,
                                  listen: false)
                              .missionList;
                          createMission(
                            context,
                            Mission(
                              missionId: missionList[missionList.length - 1]
                                      .missionId +
                                  1,
                              missionName: nameController.text,
                              createdDate: DateTime.now().toString(),
                              createdBy:
                                  Provider.of<User>(context, listen: false)
                                      .name,
                              description: descriptionController.text,
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
