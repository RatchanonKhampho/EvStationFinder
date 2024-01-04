import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/Signin.dart';
import 'package:ev_charger/utils/next_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  Future getData() async {
    final sp = context.read<SignInProvide>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvide>();

    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    sp.userSignout();
                    // nextScreenReplace(context, HomeScreen());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: backgroundwhite,
                  ),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    nextScreen(context, sign_in());
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(
                          'https://t4.ftcdn.net/jpg/02/29/75/83/240_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg')),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Personal Information',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20),
                  textfilewidget(
                    leading: Icons.person_2_outlined,
                    title: 'Name',
                    trailing: '${sp.name}',
                  ),
                  SizedBox(height: 20),
                  textfilewidget(
                      leading: Icons.email_outlined,
                      trailing: '${sp.email}',
                      title: 'Email'),
                  SizedBox(height: 20),
                  textfilewidget(
                      leading: Icons.phone_android_outlined,
                      title: 'Mobile Phone',
                      trailing: '${sp.provider}'),
                  SizedBox(height: 20),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Security',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20),
                  change(
                    leading: Icons.lock,
                    title: "Change Password",
                  )
                  /*Text(
                    'Payment',
                    style: TextStyle(fontSize: 25),
                  ),*/
                  // MyWallet()
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget textfilewidget({
    required IconData leading,
    required String title,
    required String trailing,
  }) =>
      ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(20)),
        leading: Icon(leading),
        title: Text(title),
        trailing: Text(trailing),
      );

  Widget change({
    required IconData leading,
    required String title,
  }) =>
      ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 2, color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(20)),
        leading: Icon(leading),
        title: Text(title),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios_outlined),
          onPressed: () => null,
        ),
      );
}
