import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:mission_functionlity/components/rectangular_round_button.dart';
import 'package:mission_functionlity/logic/mission_students_api.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';

class AddStudentsFromUsernameScreen extends StatefulWidget {
  const AddStudentsFromUsernameScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentsFromUsernameScreen> createState() =>
      _AddStudentsFromUsernameScreenState();
}

class _AddStudentsFromUsernameScreenState
    extends State<AddStudentsFromUsernameScreen> {
  List<User> _studentsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Students'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Search Username : '),
                  Expanded(
                    child: TypeAheadField<User>(
                      textFieldConfiguration: const TextFieldConfiguration(
                          autofocus: false,
                          style: TextStyle(fontSize: 15),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) => MissionStudentsApi()
                          .getAllStudents
                          .where((element) => element.username
                              .toLowerCase()
                              .contains(pattern.toLowerCase())),
                      itemBuilder: (context, User suggestion) {
                        return ListTile(
                          // leading: Icon(Icons.shopping_cart),
                          title: Text(suggestion.username),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        // print(suggestion.username);
                        if (!_studentsList.contains(suggestion)) {
                          _studentsList.add(suggestion);
                          setState(() {});
                        } else {
                          showSnackBarWithNoAction(context,
                              'Student already selected', Colors.redAccent);
                        }
                      },
                      // noItemsFoundBuilder: (context) => Text("NOT FOUND"),
                    ),
                  ),
                ],
              ),
            ),
            _studentsList.isNotEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        addVerticalSpace(15),
                        const Text('Selected Students : '),
                        Expanded(
                          child: ListView.builder(
                              itemCount: _studentsList.length,
                              itemBuilder: (context, index) => ListTile(
                                    title: Text(_studentsList[index].name),
                                    subtitle: Text(
                                        'Username: ${_studentsList[index].username}'),
                                    trailing: Text(_studentsList[index]
                                        .userClass
                                        .toString()),
                                  )),
                        ),
                      ],
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text('No Students Selected'),
                    ),
                  ),
            _studentsList.isNotEmpty
                ? RectangularRoundButton(
                    text: 'Add Students',
                    onPressedCallback: () {
                      Navigator.pop(context, _studentsList);
                    },
                  )
                : addVerticalSpace(0),
            addVerticalSpace(10),
          ],
        ),
      ),
    );
  }
}
