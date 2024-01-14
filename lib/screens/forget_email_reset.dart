import 'package:ev_charger/main.dart';
import 'package:ev_charger/widgetd/text_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/next_Screen.dart';
import '../widgetd/custombutton.dart';
import 'Signin.dart';

class ForgotResetEmail extends StatefulWidget {
  const ForgotResetEmail({super.key});

  @override
  State<ForgotResetEmail> createState() => _ForgotResetEmailState();
}

class _ForgotResetEmailState extends State<ForgotResetEmail> {
  final TextEditingController _emailcontroller = TextEditingController();
  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    _emailcontroller.dispose();

    super.dispose();
  }

  Future passwordReset() async {
    {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailcontroller.text.trim());
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! check your email'),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: ListTile(
                leading: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => sign_in()),
                  ),
                  icon: Icon(Icons.arrow_back_ios_new),
                  color: textmain3,
                ),
                title: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Forgot Password",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: textmain3),
                    )),
                trailing: Text(""),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Text(
                    "Forgot Your Password",
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: textmain,
                      //letterSpacing: 1
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please enter your phone and we will send you a link to return to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textmain3,
                        fontSize: 14,
                        //letterSpacing: 2,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFromFile(
                      controller: _emailcontroller,
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      suffixIcon: Icons.email_outlined),
                  SizedBox(height: 50),
                  CustomButtonNext(text: "CONTINUE", onPressed: passwordReset),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              nextScreen(context, sign_in());
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 16,
                                color: buttoncolors,
                              ),
                            ))
                      ]),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
