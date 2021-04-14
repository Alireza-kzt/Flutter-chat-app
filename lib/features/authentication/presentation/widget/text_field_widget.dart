import 'package:flutter/material.dart';
import '../../../../theme.dart';

class TextFieldWidget extends StatelessWidget {
  final Function validator;
  final icon;
  final String hintText;
  final margin;
  final Function onSaved;
  TextFieldWidget({this.icon, this.hintText, this.validator, this.margin, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: theme.primaryColor,
            ),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:
                BorderSide(color: Color(0xffd5dfe5), width: 1.4))),
      ),
    );
  }
}
