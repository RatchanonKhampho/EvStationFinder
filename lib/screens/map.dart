import 'package:ev_charger/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final AuthService auth;
  const HomeScreen({required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Home Page',
              ),
              const SizedBox(
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
