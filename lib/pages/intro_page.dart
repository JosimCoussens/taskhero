import 'package:flutter/material.dart';
import 'package:taskhero/pages/login_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // Show login page after 2 seconds
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
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
