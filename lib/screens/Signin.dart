import 'dart:async';

import 'package:ev_charger/provider/internet_provider.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:ev_charger/utils/snack_bar.dart';
import 'package:ev_charger/widgetd/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main.dart';
import '../utils/next_Screen.dart';
import 'forget_phone.dart';
import 'home_screens.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController facebookController =
      RoundedLoadingButtonController();
  final TextEditingController _emaiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _doSomething() async {
    Timer(const Duration(seconds: 1), () {
      _btnController.success();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(child: logoWidget('images/login.png')),
                  Container(
                    child: const Column(
                      children: [
                        Text(
                          'Welcome',
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
                          child: Column(
                            children: [
                              reusableTextField(
                                  "Enter UserName",
                                  Icons.person_outlined,
                                  false,
                                  _emaiController),
                              SizedBox(height: 20),
                              reusableTextField("Enter Password", Icons.lock,
                                  false, _passwordController),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              nextScreen(context, ForgetPhone());
                            },
                            child: const Text(
                              'Forget Password',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        firebaseUIButton(context, "Sign In", () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emaiController.text,
                                  password: _passwordController.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          });
                        }),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        RoundedLoadingButton(
                          onPressed: () {
                            handleGoogleSignIn();
                          },
                          controller: googleController,
                          successColor: Colors.red,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          color: Colors.red,
                          child: Wrap(
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // facebook login button
                        RoundedLoadingButton(
                          onPressed: () {
                            handleFacebookAuth();
                          },
                          controller: facebookController,
                          successColor: Colors.blue,
                          width: MediaQuery.of(context).size.width * 0.80,
                          elevation: 0,
                          borderRadius: 25,
                          color: Colors.blue,
                          child: Wrap(
                            children: const [
                              Icon(
                                FontAwesomeIcons.facebook,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Sign in with Facebook",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

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
                                  onPressed: () {
                                    nextScreen(context, register());
                                  },
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

// handle Google Signin
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvide>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection ", Colors.red);
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, "snackMessage", Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not(ตรวจสอบว่ามีผู้ใช้อยู่หรือไม่)
          sp.checkExistingUser().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user  does not exists
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.reset();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handle Facebook Signin
  Future handleFacebookAuth() async {
    final sp = context.read<SignInProvide>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      facebookController.reset();
    } else {
      await sp.signInWithFacebook().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          facebookController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        facebookController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handle after signin(จัดการหลังจากลงชื่อเข้าใช้)
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, HomeScreen());
    });
  }
}
