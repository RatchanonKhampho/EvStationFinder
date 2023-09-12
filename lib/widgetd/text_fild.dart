import 'package:flutter/material.dart';

Widget TextFromFile({
  required String labelText,
  required String hintText,
  required IconData suffixIcon,
  required Color fillColor,
}) =>
    TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          hintText: hintText,
          labelText: labelText,
          suffixIcon: Icon(suffixIcon),
          fillColor: fillColor),
    );
