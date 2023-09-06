import 'package:ev_charger/components/square_tile.dart';
import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

// ignore: camel_case_types
class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp())),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(
                    width: 80,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  const Text(
                    'Register Account',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Email',
                        suffixIcon: const Icon(Icons.mail),
                        fillColor: backgroundblue),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Password',
                        suffixIcon: const Icon(Icons.lock),
                        fillColor: backgroundblue),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        child: const Text(
                          'Forget Password',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPhone())),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(backgroundblue),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                      ),
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SquareTile(
                        imagePath: 'images/Google.png',
                        onTap: () => AuthService().signInWithGoogle(),
                      ),
                      SquareTile(
                        imagePath: 'images/Facebook.png',
                        onTap: () => AuthService().signInFacebook(),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
