import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';

Widget TextFromFile({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  required IconData suffixIcon,
}) =>
    Container(
      width: 370,
      height: 50,
      child: TextFormField(
        controller: controller,
        cursorColor: buttoncolors,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          color: textmain,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 16, color: buttoncolors, fontWeight: FontWeight.w700),
            hintText: hintText,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: textmain3,
                letterSpacing: 2,
                fontSize: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: buttoncolors),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            suffixIcon: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: bgcolor,
              ),
              child: Icon(
                suffixIcon,
                color: buttoncolors,
                size: 25,
              ),
            )),
      ),
    );

Widget TextFromFileEmail({
  required TextEditingController controller,
}) =>
    Container(
      child: TextFormField(
        controller: controller,
        autofillHints: [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        cursorColor: buttoncolors,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: Text1),
        decoration: const InputDecoration(
          label: Text("Username"),
          labelStyle: TextStyle(
            fontSize: 16,
            color: textmain2,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: buttoncolors,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: buttoncolors,
            ),
          ),
        ),
        /*validator: 
        },*/
      ),
    );

Widget TextFromFilePassword({
  required TextEditingController controller,
}) =>
    Container(
      child: TextFormField(
        controller: controller,
        autofillHints: [AutofillHints.email],
        keyboardType: TextInputType.emailAddress,
        cursorColor: buttoncolors,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: Text1),
        decoration: const InputDecoration(
          label: Text("Password"),
          labelStyle: TextStyle(
            fontSize: 16,
            color: textmain2,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: buttoncolors,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              color: buttoncolors,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            //borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              color: buttoncolors,
            ),
          ),
        ),
        /*validator: 
        },*/
      ),
    );
Widget change({
  required IconData leading,
  required String title,
}) =>
    ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.lightBlue),
          borderRadius: BorderRadius.circular(20)),
      leading: Icon(leading),
      title: Text('title'),
      trailing: IconButton(
        icon: Icon(Icons.lock),
        onPressed: () => null,
      ),
    );
Widget textfilewidget({
  required IconData leading,
  required String title,
  required String trailing,
}) =>
    ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: Colors.lightBlue),
          borderRadius: BorderRadius.circular(20)),
      leading: Icon(leading),
      title: Text('title'),
      trailing: Text('trailing'),
    );
