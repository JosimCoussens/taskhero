import 'package:flutter/material.dart';
import 'package:taskhero/auth.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/pages/home_page.dart';
import 'package:taskhero/pages/intro_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        // If there is a user, snapshot has data
        if (snapshot.hasData) {
          AppParams.userId = snapshot.data!.uid;
          return HomePage();
        } else {
          return const IntroPage();
        }
      },
    );
  }
}
