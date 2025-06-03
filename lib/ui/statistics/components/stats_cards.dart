import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';
import 'package:taskhero/data/user_service.dart';

Column statsCards() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildStatsCard(
              'Tasks Done',
              Icons.check_circle,
              Colors.green,
              UserService.getTotalCompleted,
              null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Streak',
              Icons.local_fire_department,
              Colors.orange,
              TodoService.getStreak,
              ' Days',
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      Row(
        children: [
          Expanded(
            child: _buildStatsCard(
              'This Week',
              Icons.calendar_today,
              Colors.purple,
              null,
              null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Average',
              Icons.trending_up,
              Colors.teal,
              null,
              null,
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildStatsCard(
  String title,
  IconData icon,
  Color color,
  Function? dataFunction,
  String? postText,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: AppColors.primary,
      borderRadius: StylingParams.borderRadius,
      border: Border.fromBorderSide(
        BorderSide(
          color: AppColors.primaryLight,
          width: StylingParams.borderThickness,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: StylingParams.borderRadius,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 16),
        dataFunction == null
            ? const Text(
              'N/A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
            : FutureBuilder(
              future: dataFunction(),
              builder:
                  (context, snapshot) => Text(
                    snapshot.data.toString() + (postText ?? ''),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
            ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
