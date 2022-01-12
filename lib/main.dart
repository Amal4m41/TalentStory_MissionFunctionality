import 'package:flutter/material.dart';
import 'package:mission_functionlity/models/user.dart';
import 'package:mission_functionlity/screens/homepage.dart';

User globalUser = User(
    username: 'dummyUsername',
    name: 'Amal',
    userClass: 0,
    schoolName: 'ABC',
    category: 'mentor');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
