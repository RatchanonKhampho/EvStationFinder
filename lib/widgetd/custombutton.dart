import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';

Widget CustomButton({required String text, required VoidCallback onPressed}) =>
    Container(
      width: 1000,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(backgroundwhite),
          backgroundColor: MaterialStateProperty.all<Color>(buttoncolors),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
    );
Widget CustomButtonNext(
        {required String text, required VoidCallback onPressed}) =>
    Container(
      width: 1000,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(backgroundwhite),
          backgroundColor: MaterialStateProperty.all<Color>(buttoncolors),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
    );
Widget CustomButtonback(
        {required String text, required VoidCallback onPressed}) =>
    Container(
      width: 1000,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(buttoncolors),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundwhite),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
    );
