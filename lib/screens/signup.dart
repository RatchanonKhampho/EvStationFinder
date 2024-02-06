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
  final TextEditingController _phoneController = TextEditingController();

  bool _acceptedPDPA = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: textmain3,
                    ),
                    title: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: textmain3),
                        )),
                    trailing: const Text("  "),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      Container(
                        child: const Column(
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
                      const SizedBox(height: 60),
                      Container(
                        child: Column(
                          children: [
                            TextFromFile(
                                controller: _userNameController,
                                labelText: "Username",
                                hintText: "Enter your username",
                                suffixIcon: Icons.supervised_user_circle_sharp),
                            const SizedBox(height: 20),
                            TextFromFile(
                                controller: _emailController,
                                labelText: "Email",
                                hintText: "Enter your e-mail",
                                suffixIcon: Icons.email_outlined),
                            const SizedBox(height: 20),
                            TextFromFilePassword(
                                controller: _passwordController,
                                labelText: "password",
                                hintText: "Enter your password",
                                suffixIcon: Icons.lock),
                            const SizedBox(height: 20),
                            TextFromFile(
                                controller: _phoneController,
                                labelText: "Telephone",
                                hintText: "Enter your Telephone",
                                suffixIcon: Icons.call),
                            const SizedBox(height: 100),
                            CustomButtonNext(
                              text: "Sign Up",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title:
                                          Text('ขออนุญาติเก็บข้อมูลตาม PDPA'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              """เรียน ผู้ใช้บริการ EV Station Finder

เพื่อให้บริการที่ดีที่สุดและปรับปรุงประสิทธิภาพการให้บริการของเรา, เราขออนุญาติเก็บ, ใช้, และประมวลผลข้อมูลส่วนบุคคลของคุณตามกฎหมายความเป็นส่วนตัวของประชาชน (PDPA).

ข้อมูลที่เรารวบรวม:

ชื่อ
อีเมล
เบอร์โทรศัพท์

วัตถุประสงค์ของการใช้ข้อมูล:

ให้บริการและสนับสนุนลูกค้า
ปรับปรุงประสิทธิภาพการให้บริการ
"""),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: _acceptedPDPA,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _acceptedPDPA = value!;
                                                  });
                                                },
                                              ),
                                              Text('ยอมรับข้อตกลงตาม PDPA'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('ยกเลิก'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_acceptedPDPA) {
                                              handleSignUp();
                                              Navigator.of(context).pop();
                                            } else {
                                              // แสดงข้อความเตือนถ้ายังไม่ยอมรับ PDPA
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'กรุณายอมรับข้อตกลงตาม PDPA'),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('ยืนยัน'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                      fontSize: 16,
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
      ),
    );
  }

  void clear() {
    _userNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _phoneController.clear();
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
          openSnackbar(context, "Error Data  ", Colors.red);
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

Widget PDPA() {
  return AlertDialog();
}
