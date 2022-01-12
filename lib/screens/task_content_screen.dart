import 'package:flutter/material.dart';
import 'package:mission_functionlity/utils/widget_functions.dart';
import 'package:provider/provider.dart';
import 'package:mission_functionlity/models/task.dart';

class TaskContentScreen extends StatelessWidget {
  const TaskContentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskName),
      ),
      body: Container(
          child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Download task file'),
                addHorizontalSpace(10),
                Icon(Icons.download_sharp),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Upload to add file'),
                addHorizontalSpace(10),
                Icon(Icons.upload_file),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
