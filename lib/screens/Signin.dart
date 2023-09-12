import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../services/auth_service.dart';
import '../widgetd/text_fild.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //head
                Container(
                  child: const Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Text2,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: const Column(
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Complete your details or conitnue with social media',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Text2,
                                  fontSize: 14,
                                  letterSpacing: 1.5),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      TextFromFile(
                          labelText: 'Email',
                          hintText: ' Enter your email',
                          suffixIcon: Icons.email,
                          fillColor: backgroundblue),
                      SizedBox(height: 25),
                      TextFromFile(
                          labelText: 'Password ',
                          hintText: 'Enter your password',
                          suffixIcon: Icons.lock,
                          fillColor: backgroundblue),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => register())),
                            child: Text(
                              'Forget Password',
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0),
                        fixedSize: const Size(300, 50),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 3),
                        primary: backgroundblue,
                        elevation: 10,
                        shadowColor: backgroundblue,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "CONTINUE",
                      style: TextStyle(fontSize: 20, color: backgroundwhite),
                    ),
                  ),
                ),
                //buttom
                Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SignInButton.mini(
                            buttonType: ButtonType.apple,
                            onPressed: null,
                          ),
                          SignInButton.mini(
                            buttonType: ButtonType.google,
                            onPressed: () => AuthService().signInWithGoogle(),
                          ),
                          SignInButton.mini(
                            buttonType: ButtonType.facebook,
                            onPressed: null,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const register())),
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 16, color: backgroundblue),
                                ))
                          ]),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
