import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';

Widget buildSectionHeader(String title) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
