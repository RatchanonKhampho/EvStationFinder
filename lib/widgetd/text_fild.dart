import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';

Widget TextFromFile({
  required String labelText,
  required String hintText,
  required IconData suffixIcon,
}) =>
    Container(
      width: 370,
      height: 70,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.purple,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: Text1),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 16, color: backgroundblue),
            hintText: hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: text3,
                letterSpacing: 2,
                fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundwhite,
              ),
              child: Icon(
                suffixIcon,
                color: backgroundblue,
                size: 25,
              ),
            )),
      ),
    );
