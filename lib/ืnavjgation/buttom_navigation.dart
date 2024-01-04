import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ev_charger/main.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _intpage = 0;
  GlobalKey<CurvedNavigationBarState> _curvednavigationkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _curvednavigationkey,
        index: 0,
        height: 65.0,
        items: [
          Icon(Icons.add, size: 33, color: bgcolor),
          Icon(Icons.add, size: 33, color: bgcolor),
          Icon(Icons.add, size: 33, color: bgcolor),
        ],
        color: buttoncolors,
        buttonBackgroundColor: buttoncolors,
        backgroundColor: bgcolor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _intpage = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        color: bgcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_intpage == 0) Icon(Icons.add, size: 33, color: Colors.blue),
              if (_intpage == 1) Icon(Icons.add, size: 33, color: Colors.blue),
              if (_intpage == 2) Icon(Icons.add, size: 33, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
