import 'package:flutter/material.dart';
import 'package:mission_functionlity/utils/constants.dart';

class RectangularRoundButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color bgColor;
  final VoidCallback onPressedCallback;

  const RectangularRoundButton({
    required this.text,
    this.textStyle = kWhiteTextStyleNormal,
    this.bgColor = Colors.blue,
    required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: kRoundButtonStyle.copyWith(
          backgroundColor: MaterialStateProperty.all(bgColor)),
      onPressed: onPressedCallback,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
