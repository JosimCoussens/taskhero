import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';

class Styles {
  final ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16),
    backgroundColor: AppColors.primaryLight,
    shape: const RoundedRectangleBorder(
      borderRadius: StylingParams.borderRadius,
    ),
  );
  final ButtonStyle goToPageButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor: AppColors.primaryLight,
    shape: const RoundedRectangleBorder(
      borderRadius: StylingParams.borderRadius,
    ),
  );
}

BoxDecoration backgroundImage(String imagePath) {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(imagePath),
      colorFilter: AppParams.backgroundImageColorFilter,
      fit: BoxFit.cover,
    ),
  );
}
