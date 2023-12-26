import 'package:flutter/material.dart';

import '../sidebar/navigation_bloc.dart';

class MyAccountsPage extends StatelessWidget implements NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "My Accounts",
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 28),
      ),
    );
  }
}
