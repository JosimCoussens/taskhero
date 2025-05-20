import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';

class Styles {
  final ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16),
    backgroundColor: AppColors.primaryLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
  );
  final ButtonStyle goToPageButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor: AppColors.primaryLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
  );
}
