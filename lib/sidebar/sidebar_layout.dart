import 'package:ev_charger/sidebar/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarLayuot extends StatelessWidget {
  const SidebarLayuot({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ),
    );
  }
}
