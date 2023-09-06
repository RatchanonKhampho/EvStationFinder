import 'package:ev_charger/main.dart';
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
                  width: 50,
                ),
                const Text(
                  "Forget Password",
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(),
            const Padding(
              padding: EdgeInsets.all(5.0),
              // ignore: unnecessary_const
              child: const Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 20, left: 20)),
                  Text(
                    'Please enter your phone and we will send you a link to return to your account',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
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
            SizedBox(
              height: 300,
            ),
            ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(backgroundblue),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                ),
                child: Text(
                  "CONTINUE",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
          ],
        ),
      ),
    ));
  }
}
