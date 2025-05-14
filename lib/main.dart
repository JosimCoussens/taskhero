import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/firebase_options.dart';
import 'package:taskhero/pages/home_page.dart';
import 'package:taskhero/services/user_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<void> setXp() async {
      AppParams.xp = await UserService.getXp();
    }

    setXp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}
