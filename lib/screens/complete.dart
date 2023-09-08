import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/register.dart';
import 'package:flutter/material.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
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
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const register())),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(
                    width: 120,
                  ),
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  const Text(
                    'Complete Profile',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
                        labelText: 'First Name',
                        suffixIcon: const Icon(Icons.person_outlined)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Last Name',
                        suffixIcon: const Icon(Icons.person_outlined)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Phone',
                        suffixIcon: const Icon(Icons.phone_android)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: 'Address',
                        suffixIcon: const Icon(Icons.add_home_rounded)),
                  ),
                  const SizedBox(height: 80),
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
                  const SizedBox(
                    height: 20,
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
                              'By continuing your confirm that yiu agree',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 330,
                            alignment: Alignment.center,
                            child: const Text(
                              'with our Term and Condition',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 254, 169, 169),
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
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
