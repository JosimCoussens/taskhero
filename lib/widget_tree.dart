import 'package:flutter/material.dart';
import 'package:taskhero/data/auth/auth.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/user_service.dart';
import 'package:taskhero/ui/home/home_page.dart';
import 'package:taskhero/ui/intro_page.dart';
import 'package:taskhero/data/shop/item_service.dart';
import 'package:taskhero/data/leveling/level_service.dart';
import 'package:taskhero/data/shop/money_service.dart';
import 'package:taskhero/data/leveling/xp_service.dart';

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
          // Get login method from snapshot
          AppParams.loginMethod = snapshot.data!.providerData[0].providerId;
          AppParams.userId = snapshot.data!.uid;
          return FutureBuilder(
            future: Future.wait([
              _getMoneyAndXp(),
              _getItems(),
              if (UserService.loggedInWithGoogle()) Auth().initializeCalendar(),
            ]),
            builder: (context, futureSnapshot) {
              // If the future is still loading, show a loading indicator
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const SafeArea(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return HomePage();
            },
          );
        } else {
          return const IntroPage();
        }
      },
    );
  }

  Future<void> _getMoneyAndXp() async {
    AppParams.money.value = await MoneyService.getMoney();
    AppParams.xp.value = await XpService.getXp();
    AppParams.level.value = await LevelService.getLevel();
  }

  Future<void> _getItems() async {
    await ItemService.setAppItems();
  }
}
