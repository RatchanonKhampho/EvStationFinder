import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/Forgot%20password.dart';
import 'package:flutter/material.dart';

import '../utils/next_Screen.dart';
import '../widgetd/custombutton.dart';
import '../widgetd/text_fild.dart';
import 'Signin.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _confirmController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
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
                      MaterialPageRoute(builder: (context) => ForgetPhone()),
                    ),
                    icon: Icon(Icons.arrow_back_ios_new),
                    color: textmain3,
                  ),
                  title: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Reset Password",
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
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: textmain,
                              //letterSpacing: 1
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Please enter your new password and confirm your password.',
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
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _passwordController,
                              labelText: "password",
                              hintText: "Enter your password",
                              suffixIcon: Icons.lock),
                          SizedBox(height: 20),
                          TextFromFile(
                              controller: _confirmController,
                              labelText: "Confirm password",
                              hintText: "Enter your Confirm password",
                              suffixIcon: Icons.lock),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          CustomButtonNext(
                            text: "CONTINUE",
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => sign_in()),
                            ),
                          ),
                          Row(
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
                                      nextScreen(context, sign_in());
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: buttoncolors,
                                      ),
                                    ))
                              ]),
                        ],
                      ),
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
}
