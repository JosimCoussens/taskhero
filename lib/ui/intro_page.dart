import 'package:flutter/material.dart';
import 'package:taskhero/ui/login_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      mounted
          ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          )
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 250),
              const SizedBox(height: 15),
              const Text(
                'Taskhero',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
