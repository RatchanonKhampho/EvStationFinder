import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';

import '../widgetd/text_fild.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
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
                          child: Image.asset("images/create.png")),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              'Create Password',
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
                              'Please enter your new password and confirm your password',
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
                              labelText: 'Password ',
                              hintText: 'Enter your password',
                              suffixIcon: Icons.lock,
                            ),
                            TextFromFile(
                              labelText: 'Confirm Password ',
                              hintText: 'Enter your password',
                              suffixIcon: Icons.lock,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp())),
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
                                style: TextStyle(
                                    fontSize: 20, color: backgroundwhite),
                              ),
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
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const register())),
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: backgroundblue),
                                      ))
                                ])
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
