import 'package:flutter/material.dart';

class GlobalMethods {
  void showDialogBox({
    required BuildContext context,
    required String title,
    required String subtitle,
    required void Function() onPressedTrue,
    required void Function() onPressedFalse,
  }) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                TextButton(
                    onPressed: () {
                      onPressedFalse();
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      onPressedTrue();
                      // Navigator.pop(context);
                    },
                    child: Text('OK'))
              ],
            ));
  }
}
