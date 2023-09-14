import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../main.dart';
import '../services/auth_service.dart';
import '../widgetd/text_fild.dart';
import 'forget_phone.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundwhite,
          elevation: 0,
          title: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              'Sign In',
              style: TextStyle(
                  color: Text2, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          )),
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
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontSize: 40,
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
                              fillColor: backgroundblue),
                        ),
                        const SizedBox(height: 25),
                        TextFromFile(
                            labelText: 'Password ',
                            hintText: 'Enter your password',
                            suffixIcon: Icons.lock,
                            fillColor: backgroundblue),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPhone())),
                            child: const Text(
                              'Forget Password',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => null,
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
                        SignInButton(
                            buttonType: ButtonType.apple,
                            imagePosition: ImagePosition.left,
                            //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                            buttonSize: ButtonSize.large,
                            btnTextColor: Text2,
                            btnColor: Color(0xFFE7E7EE),
                            width: 250,
                            //[width] Use if you change the text value.
                            btnText: 'Sign in with Apple',
                            onPressed: () {
                              print('click');
                            }),
                        SizedBox(height: 10),
                        SignInButton(
                          buttonType: ButtonType.google,
                          imagePosition: ImagePosition.left,
                          elevation: 4,
                          //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                          buttonSize: ButtonSize.large,
                          btnTextColor: Text2,
                          btnColor: Color(0xFFE7E7EE),
                          width: 250,
                          //[width] Use if you change the text value.
                          btnText: 'Sign in with Google',
                          onPressed: () => AuthService().signInWithGoogle(),
                        ),
                        SizedBox(height: 10),
                        SignInButton(
                            buttonType: ButtonType.facebook,
                            imagePosition: ImagePosition.left,
                            //[buttonSize] You can also use this in combination with [width]. Increases the font and icon size of the button.
                            buttonSize: ButtonSize.large,
                            btnTextColor: Text2,
                            btnColor: Color(0xFFE7E7EE),
                            width: 250,
                            //[width] Use if you change the text value.
                            btnText: 'Sign in with Facebook',
                            onPressed: () {
                              print('click');
                            }),
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
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
