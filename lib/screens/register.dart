import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/home_screens.dart';
import 'package:ev_charger/widgetd/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

// ignore: camel_case_types
class _registerState extends State<register> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
                    child: logoWidget("images/create.png"),
                  ),
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
                        reusableTextField("Enter UserName",
                            Icons.person_outline, false, _userNameController),
                        const SizedBox(height: 20),
                        reusableTextField("Enter Email Id",
                            Icons.person_outline, false, _emailController),
                        const SizedBox(height: 20),
                        reusableTextField("Enter Password", Icons.lock_outlined,
                            true, _passwordController),
                        const SizedBox(height: 20),
                        reusableTextField(
                            "Enter Phone Number",
                            Icons.phone_android_outlined,
                            false,
                            _phoneController),
                        const SizedBox(height: 20),
                        firebaseUIButton(context, "Sign Up", () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          )
                              .then((value) {
                            print("Created New Account");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        })
                      ],
                    ),
                  ),
                  /*Container(
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
                  ),*/
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
