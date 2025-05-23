import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';

AlertDialog showDetailsDialog(
  Item item,
  double imageHeight,
  BuildContext context,
) {
  return AlertDialog(
    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(item.imagePath, height: imageHeight, fit: BoxFit.contain),
        const SizedBox(height: 12),
        Text(
          'Bonus Effect: XP gained +${((item.xpGain - 1) * 100).toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            'Close',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ],
  );
}
