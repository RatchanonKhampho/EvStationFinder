import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthService auth;
  HomeScreen({required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Page',
              ),
              SizedBox(
                height: 30,
              ),
              auth.currentUser != null
                  ? Text('User: ${auth.currentUser?.email}')
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
