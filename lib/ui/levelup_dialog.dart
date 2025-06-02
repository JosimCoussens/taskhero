import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/item_service.dart';

Dialog levelUpDialog() {
  final reachedLevel = AppParams.level.value;
  final unlockedItems = ItemService.getAtLevel(reachedLevel);
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: StylingParams.borderRadius,
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
          spacing: AppParams.generalSpacing,
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
            Text(
              'Congratulations on reaching level $reachedLevel!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            unlockedItems.isNotEmpty
                ? _showRewards(unlockedItems)
                : _noRewardsText(),
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

Column _showRewards(List<Item> unlockedItems) {
  return Column(
    spacing: AppParams.generalSpacing / 2,
    children: [
      const Text(
        'You have unlocked new rewards:',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white70),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            unlockedItems
                .map(
                  (item) => Image.asset(item.imagePath, width: 50, height: 50),
                )
                .toList(),
      ),
    ],
  );
}

Text _noRewardsText() {
  return const Text(
    'No new rewards unlocked at this level.',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.white70),
  );
}
