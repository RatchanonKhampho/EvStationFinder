import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/create_password.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';

class ForgetPhone extends StatefulWidget {
  const ForgetPhone({super.key});

  @override
  State<ForgetPhone> createState() => _ForgetPhoneState();
}

class _ForgetPhoneState extends State<ForgetPhone> {
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
                  width: 75,
                ),
                const Text(
                  "Forget Password",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 25),
              child: Column(
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "Please enter your phone and we will send ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: const Text(
                          "you a link to return to your account ",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  labelText: 'Phone',
                  suffixIcon: const Icon(Icons.phone_android),
                  fillColor: backgroundblue),
            ),
            const SizedBox(
              height: 300,
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreatePassword())),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  fixedSize: const Size(300, 60),
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
              height: 40,
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
                      style: TextStyle(fontSize: 16, color: backgroundblue),
                    ))
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
