import 'package:flutter/material.dart';
import '../../../../theme.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  SubmitButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      color: theme.primaryColor,
      padding:
      EdgeInsets.symmetric(vertical: 10.0, horizontal: 26.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.0)),
      onPressed: onPressed,
    );
  }
}
