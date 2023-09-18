import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_buttons/flutter_custom_buttons.dart';
import 'package:pinput/pinput.dart';

class Forget_otp extends StatefulWidget {
  final String verificationId;
  const Forget_otp({super.key, required this.verificationId});

  @override
  State<Forget_otp> createState() => _Forget_otpState();
}

class _Forget_otpState extends State<Forget_otp> {
  String? otpcode;
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
                MaterialPageRoute(builder: (context) => MyApp()),
              ),
              icon: Icon(Icons.arrow_back_ios_new),
              color: backgroundblue,
            ),
          ],
        ),
        title: Text(
          'OTP Verification',
          style: TextStyle(color: Text2, letterSpacing: 2, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(children: [
          Column(
            children: [
              Text(
                "OTP Verification",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36, fontWeight: FontWeight.w700, color: Text1),
              ),
              Text(
                'We sent code to +66 97 350 ****',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16, color: Text2, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: backgroundblue),
                  ),
                  textStyle: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: Text1),
                ),
                onSubmitted: (value) {
                  setState(() {
                    otpcode = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                child: Buttons(
                  background: backgroundblue,
                  width: 100.0,
                  height: 60.0,
                  radius: 12.0,
                  elevation: 2.0,
                  txt: "Button",
                  textColor: Colors.white,
                  fontSize: 20.0,
                  onTap: () {},
                ),
              )
            ],
          ),
        ]),
      )),
    );
  }
}
