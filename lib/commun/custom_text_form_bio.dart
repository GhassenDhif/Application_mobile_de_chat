import 'package:flutter/material.dart';

import '../constants.dart';


class CustomTextFieldBio extends StatelessWidget {
  const CustomTextFieldBio({
    Key key,
    @required this.hintTile,
    @required this.labelTitle,
    @required this.icon,
    this.type,
    this.validate,
    this.complete,
    this.onchange, this.node,
  }) : super(key: key);
  final String hintTile;
  final String labelTitle;
  final Widget icon;
  final TextInputType type;
  final Function(String) validate;
  final Function complete;
  final Function(String) onchange;
  final FocusNode node;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      maxLines: 5,
      focusNode: node,
      decoration: InputDecoration(
        hintText: hintTile,
        labelText: labelTitle,
        suffixIcon: icon,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: true,
        errorBorder: borderSide,
        enabledBorder: borderSide,
        border: borderSide,
        hintStyle:
        Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.grey),
      ),
      onEditingComplete: complete,
      onChanged: onchange,
      validator: validate,
    );
  }
}