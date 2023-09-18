import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/create_password.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:flutter/material.dart';

class Forget_otp extends StatefulWidget {
  final String verificationId;
  const Forget_otp({super.key, required this.verificationId});

  @override
  State<Forget_otp> createState() => _Forget_otpState();
}

class _Forget_otpState extends State<Forget_otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundwhite,
        elevation: 0,
        leading: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgetPhone()),
              ),
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Text1,
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    "OTP Verification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Text1),
                  ),
                  Text(
                    'We sent code to +66 97 350 ****',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Text2,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(first: true, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: false),
                      _textFieldOTP(first: false, last: true),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePassword())),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        fixedSize: const Size(180, 50),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                        primary: backgroundblue,
                        elevation: 10,
                        shadowColor: backgroundblue,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePassword())),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        fixedSize: const Size(180, 50),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                        primary: backgroundblue,
                        elevation: 10,
                        shadowColor: backgroundblue,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: 115,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: text3),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: backgroundblue),
                borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
