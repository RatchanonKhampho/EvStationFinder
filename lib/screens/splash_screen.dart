import 'dart:async';

import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/Signin.dart';
import 'package:ev_charger/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/next_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // init State
  void initState() {
    final sp = context.read<SignInProvide>();
    super.initState();
    // create timer of 2
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? nextScreen(context, const sign_in())
          : nextScreen(context, const profile());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Image(
          image: AssetImage("images/login.png"),
          height: 200,
          width: 200,
        ),
      )),
    );
  }
}
