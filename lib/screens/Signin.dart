// ignore_for_file: file_names

import 'dart:async';

import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../main.dart';
import '../provider/auth_provider.dart';
import '../services/auth_service.dart';
import '../widgetd/text_fild.dart';
import 'forget_phone.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(const Duration(seconds: 1), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 200,
                      height: 200,
                      color: backgroundwhite,
                      child: Image.asset('images/login.png')),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: const Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3.2,
                              color: Text1),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Complete your details or conitnue with social media',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Text2,
                              fontSize: 16,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: TextFromFile(
                            labelText: 'Email',
                            hintText: ' Enter your email',
                            suffixIcon: Icons.email,
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextFromFile(
                          labelText: 'Password ',
                          hintText: 'Enter your password',
                          suffixIcon: Icons.lock,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              ap.isSignedIn == true
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPhone(),
                                      ));
                            },
                            child: const Text(
                              'Forget Password',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        RoundedLoadingButton(
                          child: Text('CONTINUE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 3)),
                          color: backgroundblue,
                          controller: _btnController,
                          onPressed: _doSomething,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SignInButton.mini(
                                buttonType: ButtonType.apple,
                                //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                                buttonSize: ButtonSize.large,
                                btnColor: const Color(0xFFE7E7EE),
                                //[width] Use if you change the text value.
                                onPressed: () {
                                  print('click');
                                }),
                            SignInButton.mini(
                              buttonType: ButtonType.google,
                              elevation: 4,
                              //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                              buttonSize: ButtonSize.large,
                              btnColor: const Color(0xFFE7E7EE),
                              //[width] Use if you change the text value.
                              onPressed: () => AuthService().signInWithGoogle(),
                            ),
                            SignInButton.mini(
                                buttonType: ButtonType.facebook,

                                //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                                buttonSize: ButtonSize.large,
                                btnColor: const Color(0xFFE7E7EE),

                                //[width] Use if you change the text value.

                                onPressed: () {
                                  print('click');
                                }),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
