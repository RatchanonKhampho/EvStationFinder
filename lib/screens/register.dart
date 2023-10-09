import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/home_screens.dart';
import 'package:ev_charger/widgetd/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/internet_provider.dart';
import '../provider/sign_in_provider.dart';
import '../utils/next_Screen.dart';
import '../utils/snack_bar.dart';

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

  void controller() {
    _emailController.text;
    _passwordController.text;
    _phoneController.text;
    _userNameController.text;
  }

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
                        ElevatedButton(
                          onPressed: () {
                            handleSignUp();
                          },
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

  Future handleSignUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final sp = context.read<SignInProvide>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection ", Colors.red);
    } else {
      await sp.signUpWithEmailAndPassword(email, password).then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, "snackMessage", Colors.red);
          _emailController.dispose;
          _passwordController.dispose;
          _phoneController.dispose;
          _userNameController.dispose;
        } else {
          // checking whether user exists or not(ตรวจสอบว่ามีผู้ใช้อยู่หรือไม่)
          sp.checkExistingUser().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        email;
                        password;
                        handleAfterSignIn();
                      })));
            } else {
              // user  does not exists
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        email;
                        password;
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
