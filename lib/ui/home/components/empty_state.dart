import 'package:flutter/material.dart';

Widget buildEmptyState() {
  return SafeArea(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/knight.png', height: 300),
          const SizedBox(height: 20),
          const Text(
            'What do you want to do today?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text('Tap + to add your tasks', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
