import 'package:flutter/material.dart';
import 'package:taskhero/constants.dart';

class Styles {
  final ButtonStyle saveButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 16),
    backgroundColor: AppColors.primaryLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
  );
}
