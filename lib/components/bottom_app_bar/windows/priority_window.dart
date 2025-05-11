import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';

Future<int?> showPriority(BuildContext context) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (context) {
      int selectedPriority = 0;
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WindowHeader(title: "Choose Priority"),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: List.generate(10, (index) {
                    final int priority = index + 1;
                    final isSelected = selectedPriority == priority;
                    return GestureDetector(
                      onTap:
                          () => setState(() {
                            selectedPriority =
                                (selectedPriority == priority) ? 0 : priority;
                          }),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.primaryLight
                                  : AppColors.primary,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              offset: const Offset(6, 6),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.flag,
                                color: Colors.white,
                                size: 36,
                              ),
                              Text(
                                '$priority',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Components().buttons(
                  context,
                  () => Navigator.pop(context), // Cancel
                  () => Navigator.pop(context, selectedPriority), // Confirm
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
