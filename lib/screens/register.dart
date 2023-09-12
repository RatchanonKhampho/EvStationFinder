import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/complete.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

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
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp())),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Register Account',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Container(
                          height: 40,
                          width: 330,
                          alignment: Alignment.center,
                          child: const Text(
                            'Complete your details or continue',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 330,
                          alignment: Alignment.center,
                          child: const Text(
                            'with social media',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
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
                    const SizedBox(height: 30),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Confirm Password',
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
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CompleteProfile())),
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
