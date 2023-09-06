import 'package:ev_charger/components/square_tile.dart';
import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';

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
              Row(
                children: [
                  SizedBox(
                    width: 130,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Email',
                          suffixIcon: Icon(Icons.mail),
                          fillColor: backgroundblue),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          labelText: 'Password',
                          suffixIcon: Icon(Icons.lock),
                          fillColor: backgroundblue),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
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
                                  builder: (context) => ForgetPhone())),
                        ),
                      ],
                    ),
                    SizedBox(
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
                              MaterialStateProperty.all(EdgeInsets.all(20)),
                        ),
                        child: Text(
                          "CONTINUE",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                    SizedBox(
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const register())),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontSize: 20, color: backgroundblue),
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
