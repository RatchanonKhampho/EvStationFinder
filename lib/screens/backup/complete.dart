/*import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/signup.dart';
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
      appBar: AppBar(
        backgroundColor: backgroundwhite,
        elevation: 0,
        leading: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const register()),
              ),
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Text1,
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
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: backgroundwhite,
                    child: Image.asset("images/complete.png"),
                  ),
                  Container(
                    child: const Column(
                      children: [
                        Text(
                          'Complete Profile',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 3.2,
                              color: Text1),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Complete your details or conitnue with social media',
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
                  /* Container(
                    child: Column(
                      children: [
                        Container(
                          child: TextFromFile(
                            
                            labelText: 'Email',
                            hintText: ' Enter your email',
                            suffixIcon: Icons.email,
                          ),
                        ),
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
                        TextFromFile(
                          labelText: 'Confirm Password ',
                          hintText: 'Enter your password',
                          suffixIcon: Icons.lock,
                        ),
                      ],
                    ),
                  ),*/
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CompleteProfile())),
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
                            style:
                                TextStyle(fontSize: 20, color: backgroundwhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(),
                  Container(),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
*/