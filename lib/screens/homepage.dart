import 'package:flutter/material.dart';
import 'missions_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TalentStory'),
      ),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MissionsScreen())),
            child: Text('Go to mission screen'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
          ),
        ),
      ),
    );
  }
}
