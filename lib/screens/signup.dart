import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/home_screens.dart';
import 'package:ev_charger/widgetd/custombutton.dart';
import 'package:ev_charger/widgetd/text_fild.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/internet_provider.dart';
import '../provider/sign_in_provider.dart';
import '../utils/next_Screen.dart';
import '../utils/snack_bar.dart';
import 'Signin.dart';

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
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: textmain3),
                      )),
                  trailing: Text(""),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Let’s Get Started!",
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: textmain,
                              //letterSpacing: 1
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Create an account to EV Station to get all features',
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
                      child: Column(
                        children: [
                          TextFromFile(
                              controller: _emailController,
                              labelText: "Username",
                              hintText: "Enter your username",
                              suffixIcon: Icons.supervised_user_circle_sharp),
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _passwordController,
                              labelText: "password",
                              hintText: "Enter your password",
                              suffixIcon: Icons.lock),
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _emailController,
                              labelText: "Confirm password",
                              hintText: "Enter your Confirm password",
                              suffixIcon: Icons.email_outlined),
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _emailController,
                              labelText: "Email",
                              hintText: "Enter your e-mail",
                              suffixIcon: Icons.email_outlined),
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _emailController,
                              labelText: "Telephone",
                              hintText: "Enter your Telephone",
                              suffixIcon: Icons.call),
                          SizedBox(height: 100),
                          CustomButtonNext(
                              text: "CONTINUE", onPressed: handleSignUp),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  nextScreen(context, sign_in());
                                },
                                child: const Text(
                                  'Sign In here',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: buttoncolors,
                                  ),
                                ))
                          ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clear() {
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
    _userNameController.clear();
  }

  Future handleSignUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _userNameController.text;
    final phone = _phoneController.text;

    final sp = context.read<SignInProvide>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection ", Colors.red);
    } else {
      await sp
          .signUpWithEmailAndPassword(email, password, name, phone)
          .then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, "Error ", Colors.red);
          clear();
        } else {
          // checking whether user exists or not(ตรวจสอบว่ามีผู้ใช้อยู่หรือไม่)
          sp.checkExistingUser().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        handleAfterSignIn();
                      })));
            } else {
              // user  does not exists
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
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
