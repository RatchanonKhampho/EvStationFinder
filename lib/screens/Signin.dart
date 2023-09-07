import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 160,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Welcome Back',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 40,
                              width: 330,
                              alignment: Alignment.center,
                              child: const Text(
                                'Complete your details or conitnue',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 330,
                              alignment: Alignment.center,
                              child: const Text(
                                'with social media',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 50),
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
                      height: 180,
                    ),
                    ElevatedButton(
                      onPressed: () => null,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          fixedSize: const Size(300, 50),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w800),
                          primary: backgroundblue,
                          elevation: 10,
                          shadowColor: backgroundblue,
                          shape: const StadiumBorder()),
                      child: const Text(
                        "CONTINUE",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SignInButton.mini(
                          buttonType: ButtonType.apple,
                          onPressed: null,
                        ),
                        SignInButton.mini(
                          buttonType: ButtonType.google,
                          onPressed: () => AuthService().signInWithGoogle(),
                        ),
                        SignInButton.mini(
                          buttonType: ButtonType.facebook,
                          onPressed: null,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                                    builder: (context) => const register())),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 16, color: backgroundblue),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
