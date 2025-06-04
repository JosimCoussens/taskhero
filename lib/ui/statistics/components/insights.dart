import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/data_service.dart';

Container insights(List<Todo> completedTodos) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: StylingParams.borderRadius,
      border: Border.all(
        color: AppColors.primaryLight,
        width: StylingParams.borderThickness,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.25),
                borderRadius: StylingParams.borderRadius,
              ),
              child: Icon(
                Icons.lightbulb,
                color: Colors.amber.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Insights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInsightItem(
          'Your most productive day is ${DataService.getMostProductiveDay(completedTodos)}',
          Icons.star,
        ),
        _buildInsightItem(
          'You complete most tasks at ${DataService.getMostProductiveTime(completedTodos)}',
          Icons.wb_sunny,
        ),
        _buildInsightItem(
          'Keep up the great work! You\'re on a ${DataService.getStreak(completedTodos)}-day streak',
          Icons.emoji_events,
        ),
      ],
    ),
  );
}

Widget _buildInsightItem(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, size: 16, color: Colors.white),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
