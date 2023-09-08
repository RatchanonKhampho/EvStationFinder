import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/forget_phone.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';

class CreatePassword extends StatefulWidget {
  const CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
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
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPhone())),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const SizedBox(
                  width: 70,
                ),
                const Text(
                  "Create Password",
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Create Password',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      width: 370,
                      alignment: Alignment.center,
                      child: const Text(
                        'Please enter your new password',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 370,
                      alignment: Alignment.center,
                      child: const Text(
                        'and confirm your password.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                )
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
                  labelText: 'Create Password',
                  suffixIcon: const Icon(Icons.lock),
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
                  labelText: 'Confirm Password',
                  suffixIcon: const Icon(Icons.lock),
                  fillColor: backgroundblue),
            ),
            const SizedBox(
              height: 250,
            ),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15.0),
                  fixedSize: const Size(300, 50),
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w800),
                  // ignore: deprecated_member_use
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
