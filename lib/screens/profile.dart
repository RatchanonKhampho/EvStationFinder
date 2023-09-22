import 'package:ev_charger/main.dart';
import 'package:ev_charger/screens/Signin.dart';
import 'package:ev_charger/screens/map.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sign_in())),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => sign_in())),
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
                    backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/02/29/75/83/240_F_229758328_7x8jwCwjtBMmC6rgFzLFhZoEpLobB6L8.jpg')
                  ),
                  Align(
                    alignment: Alignment.centerLeft  ,
                    child: Text('Personal Information',
                      style: TextStyle(
                          fontSize: 25
                      ),
                    ),
                  ),
                  Name(),
                  Email(),
                  Moblie(),
                  Address(),
                  Text('Security',style: TextStyle(
                    fontSize: 25
                  ),
                  ),
                  password(),
                  Text('Payment',style: TextStyle(
                      fontSize: 25
                  ),
                  ),
                  MyWallet()
                ],
                
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget Name() => ListTile(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 2, color: Colors.lightBlue),
      borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.person_2_rounded),
    title: Text('Name'),
    trailing: Text('chayut yuttapornpong'),

  );
  Widget Email() => ListTile(
    shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.email_rounded),
    title: Text('Email'),
    trailing: Text('xxxxxxx'),

  );
  Widget Moblie() => ListTile(
    shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.phone_android),
    title: Text('Mobile phone'),
    trailing: Text('xxxxxxx'),

  );
  Widget Address() => ListTile(
    shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.phone_android),
    title: Text('Address'),
    trailing: Text('xxxxxxx'),

  );
  Widget password() => ListTile(
    shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.lock_outline_rounded),
    title: Text('Change Password'),
    trailing: Icon(Icons.arrow_forward_ios_outlined),

  );
  Widget MyWallet() => ListTile(
    shape: RoundedRectangleBorder(
        side: BorderSide(width: 2, color: Colors.lightBlue),
        borderRadius: BorderRadius.circular(20)
    ),
    leading: Icon(Icons.card_membership_rounded),
    title: Text('Change Password'),
    trailing: Icon(Icons.arrow_forward_ios_outlined),

  );
}