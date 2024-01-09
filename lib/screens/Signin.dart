import 'dart:async';

import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/internet_provider.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/signup.dart';
import 'package:ev_charger/utils/snack_bar.dart';
import 'package:ev_charger/widgetd/image.dart';
import 'package:ev_charger/widgetd/text_fild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../utils/next_Screen.dart';
import '../widgetd/custombutton.dart';
import 'Forgot password.dart';
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
  final TextEditingController _emailController = TextEditingController();
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
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    child: logoWidget("images/Logo.png"),
                  ),
                  Container(
                    child: const Text(
                      "EV Station",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 45,
                        color: buttoncolors,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 30,
                              color: textmain,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                TextFromFileEmail(controller: _emailController),
                                SizedBox(height: 20),
                                TextFromFilePasswordSign(
                                    controller: _passwordController),

                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        "Forgot ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            nextScreen(context, ForgetPhone());
                                          },
                                          child: const Text(
                                            'Password?',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: buttoncolors,
                                            ),
                                          ))
                                    ]),
                                SizedBox(height: 20),
                                CustomButton(
                                    text: 'Sign In ',
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text)
                                          .then((value) {
                                        handleAfterSignIn();
                                      }).onError((error, stackTrace) {
                                        //print("Error ${error.toString()}");
                                        _emailController.clear();
                                        _passwordController.clear();
                                        openSnackbar(
                                            context,
                                            "Error Account not found ",
                                            const Color.fromARGB(
                                                255, 244, 54, 54));
                                      });
                                    }),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 100,
                                        height: 1,
                                        color: buttoncolors),
                                    Text(
                                      "  OR  ",
                                      style: TextStyle(
                                          color: textmain2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 1,
                                      color: buttoncolors,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // facebook login button
                                RoundedLoadingButton(
                                  onPressed: () {
                                    handleFacebookAuth();
                                  },
                                  controller: facebookController,
                                  successColor: Colors.blue,
                                  //width: MediaQuery.of(context).size.width * 0.80,
                                  elevation: 0,
                                  borderRadius: 10,
                                  color: Colors.blue,
                                  child: const Wrap(
                                    children: [
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                RoundedLoadingButton(
                                  onPressed: () {
                                    handleGoogleSignIn();
                                  },
                                  controller: googleController,
                                  successColor: Colors.red,
                                  elevation: 0,
                                  borderRadius: 10,
                                  color: Colors.red,
                                  child: const Wrap(
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
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
                            nextScreen(context, register());
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 18,
                                color: buttoncolors,
                                letterSpacing: 0.5),
                          ))
                    ]),
              ),
            ],
          ),
        ),
      ),
    ));
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

  /* Future handleSignIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final sp = context.read<SignInProvide>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection ", Colors.red);
    } else {
      await sp.signInWithEmailAndPassword(email, password).then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          _emailController.clear();
          _passwordController.clear();
        } else {
          // checking whether user exists or not(ตรวจสอบว่ามีผู้ใช้อยู่หรือไม่)
          sp.checkUserExists().then((value) async {
            if (value == true) {
              openSnackbar(context, "Succress your Account", Colors.green);
              handleAfterSignIn();
            } else {
              _emailController.clear();
              _passwordController.clear();
              openSnackbar(context, "Error Account not found ", Colors.red);
              //openSnackbar(context, '$hashCode', Colors.red);
            }
          });
        }
      });
    }
  }*/

  // handle after signin(จัดการหลังจากลงชื่อเข้าใช้)
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, HomeScreen());
    });
  }
}
