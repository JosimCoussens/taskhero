import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';

Container insights() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: StylingParams.borderRadius,
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
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
                color: Color(0xFF2D3748),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInsightItem('Your most productive day is Tuesday', Icons.star),
        _buildInsightItem(
          'You complete 23% more tasks in the morning',
          Icons.wb_sunny,
        ),
        _buildInsightItem(
          'Keep up the great work! You\'re on a 7-day streak',
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
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
