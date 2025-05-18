import 'package:flutter/material.dart';
import 'package:taskhero/constants.dart';

Dialog levelUpDialog() {
  final reachedLevel = AppParams.level.value.toString();
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🎉 Level Up! 🎉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Congratulations on reaching level $reachedLevel!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 30),
            FloatingActionButton(
              backgroundColor: AppColors.primaryLight,
              child: const Icon(Icons.check, color: Colors.white),
              onPressed: () {
                AppParams.showLevelUpDialog.value = false;
              },
            ),
          ],
        ),
      ),
    ),
  );
}
