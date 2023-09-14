import 'package:ev_charger/main.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import '../widgetd/text_fild.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

// ignore: camel_case_types
class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: backgroundwhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp())),
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Text1,
        ),
        /* title: Align(alignment: Alignment.bottomLeft,
        child: Text(
          'Sign In',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Text2,
              letterSpacing: 2),
        ),
        ),*/
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  ///mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: const Column(
                        children: [
                          Text(
                            'Register Account',
                            style: TextStyle(
                                fontSize: 36, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Complete your details or conitnue with social media',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Text2, fontSize: 14, letterSpacing: 1.5),
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
                    const SizedBox(height: 25),
                    TextFromFile(
                        labelText: 'Password ',
                        hintText: 'Enter your password',
                        suffixIcon: Icons.lock,
                        fillColor: backgroundblue),
                    const SizedBox(height: 25),
                    TextFromFile(
                        labelText: "Confirm Password",
                        hintText: 'Enter your password',
                        suffixIcon: Icons.lock,
                        fillColor: backgroundblue),
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
                                      builder: (context) => const register())),
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
    );
  }
}
