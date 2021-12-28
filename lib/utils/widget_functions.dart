import 'package:flutter/material.dart';

SizedBox addVerticalSpace(double height) {
  return SizedBox(height: height);
}

SizedBox addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

SizedBox addEmptyWidget() {
  return SizedBox(width: 0, height: 0);
}

void showSnackBarWithNoAction(BuildContext context, String text,
    [Color color = Colors.blueGrey]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(text),
  ));
}
