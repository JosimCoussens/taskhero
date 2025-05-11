import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';

Future<int?> showDifficulty(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (context) {
      int selectedDifficulty = 1;
      Image coinImage = Image.asset(
        'assets/images/xp_coin.png',
        height: 20,
        width: 20,
      );

      return StatefulBuilder(
        builder: (context, setState) {
          final difficulties = [
            {'label': 'Easy', 'xp': '50%'},
            {'label': 'Normal', 'xp': '100%'},
            {'label': 'Hard', 'xp': '200%'},
          ];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WindowHeader(title: "Choose Difficulty"),
                const SizedBox(height: 16),
                ...difficulties.map((difficulty) {
                  final isSelected =
                      selectedDifficulty ==
                      (difficulty['label'] == 'Easy'
                          ? 0
                          : difficulty['label'] == 'Normal'
                          ? 1
                          : 2);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap:
                          () => setState(
                            () =>
                                selectedDifficulty =
                                    difficulty['label'] == 'Easy'
                                        ? 0
                                        : difficulty['label'] == 'Normal'
                                        ? 1
                                        : 2,
                          ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.50),
                              offset: const Offset(6, 6),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              difficulty['label']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  difficulty['xp']!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 4),
                                coinImage,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Components().buttons(
                  context,
                  () => Navigator.pop(context),
                  () => Navigator.pop(context, selectedDifficulty),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
