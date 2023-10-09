import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/home_screens.dart';
import 'package:ev_charger/widgetd/custombutton.dart';
import 'package:ev_charger/widgetd/image.dart';
import 'package:ev_charger/widgetd/text_fild.dart';
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
                        TextFromFile(
                            controller: _userNameController,
                            labelText: 'Name',
                            hintText: 'Enter your username  ',
                            suffixIcon: Icons.person_2_outlined),
                        const SizedBox(height: 20),
                        TextFromFileEmail(controller: _emailController),
                        const SizedBox(height: 20),
                        TextFromFilePassword(controller: _passwordController),
                        const SizedBox(height: 20),
                        TextFromFile(
                            controller: _phoneController,
                            labelText: 'Phone',
                            hintText: 'Enter your phonenumber  ',
                            suffixIcon: Icons.phone_android_outlined),
                        const SizedBox(height: 20),
                        CustomButton(text: "SignUp", onPressed: handleSignUp)
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
void clear(){
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
      await sp.signUpWithEmailAndPassword(email, password,).then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, "Error", Colors.red);
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
                      },
              ),
              ),
              );
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
