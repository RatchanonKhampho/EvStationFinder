import 'package:ev_charger/main.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

import '../widgetd/text_fild.dart';
import 'complete.dart';

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
      ),
      body: SafeArea(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 200,
                      height: 200,
                      color: backgroundwhite,
                      child: Image.asset("images/register.png")),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Register Account',
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
                              color: text3,
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
                        TextFromFile(
                          labelText: 'Password ',
                          hintText: 'Enter your password',
                          suffixIcon: Icons.lock,
                        ),
                        TextFromFile(
                          labelText: 'Confirm Password ',
                          hintText: 'Enter your password',
                          suffixIcon: Icons.lock,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompleteProfile())),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15.0),
                              fixedSize: const Size(300, 50),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 3),
                              primary: backgroundblue,
                              elevation: 10,
                              shadowColor: backgroundblue,
                              shape: const StadiumBorder()),
                          child: const Text(
                            "CONTINUE",
                            style:
                                TextStyle(fontSize: 20, color: backgroundwhite),
                          ),
                        ),
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
                                buttonSize: ButtonSize.large,
                                btnColor: text3,
                                onPressed: () {
                                  print('click');
                                }),
                            SignInButton.mini(
                              buttonType: ButtonType.google,
                              elevation: 4,
                              buttonSize: ButtonSize.large,
                              btnColor: text3,
                              onPressed: () => AuthService().signInWithGoogle(),
                            ),
                            SignInButton.mini(
                                buttonType: ButtonType.facebook,
                                buttonSize: ButtonSize.large,
                                btnColor: text3,
                                onPressed: () {
                                  print('click');
                                }),
                          ],
                        ),
                        SizedBox(height: 20),
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
                  Container(),
                  Container(),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
