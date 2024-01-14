import 'dart:async';

import 'package:ev_charger/main.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/Signin.dart';
import 'package:ev_charger/screens/home_screens.dart';
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
          : nextScreen(context, HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: buttoncolors,
      body: SafeArea(
        child: Center(
          child: Image(
            image: AssetImage("images/Logo.png"),
            height: 200,
            width: 200,
            color: bgcolor,
          ),
        ),
      ),
    );
  }
}
