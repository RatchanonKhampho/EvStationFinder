import 'package:ev_charger/provider/internet_provider.dart';
import 'package:ev_charger/provider/sign_in_provider.dart';
import 'package:ev_charger/screens/map.dart';
import 'package:ev_charger/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const backgroundblue = Color(0xFF535FFD);
const backgroundwhite = Color(0xFFFAFAFA);
const Text1 = Color(0xFF252644);
const Text2 = Color(0xFFACACAE);
const text3 = Color(0xFFE7E7EE);

const buttoncolors = Color(0xFFEC5E26);
const textmain = Color(0xFF252422);
const textmain2 = Color(0xFF403D38);
const textmain3 = Color(0xFFCCC6BA);
const bacolor = Color(0xFFFFFDF1);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvide()),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return  MaterialApp(
      home: SplashScreen(),
    );
  }
}
