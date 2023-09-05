import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/Signin.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            'Get  Started',
            style: TextStyle(
                fontSize: 35,
                color: backgroundblue,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Ev Finder ศูนย์รวมสถานีชาร์ตรถยนต์ไฟฟ้า',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundblue),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)))),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => sign_in())),
            child: ListTile(
              leading: Image.asset('images/Letter.png'),
              title: const Text(
                'Email',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(backgroundblue),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)))),
            onPressed: null,
            child: ListTile(
              leading: Image.asset('images/Facebook.png'),
              title: const Text(
                'Facebook',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)))),
            onPressed: null,
            child: ListTile(
              leading: Image.asset(
                'images/Google.png',
              ),
              title: const Text(
                'Google',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
