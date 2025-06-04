import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/data_service.dart';

Widget statsCards(List<Todo> completedTodos) {
  return _showCards(completedTodos);
}

Column _showCards(List<Todo> completedTodos) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildStatsCard(
              'Tasks Done',
              Icons.check_circle,
              Colors.green,
              completedTodos.length.round().toString(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Streak',
              Icons.local_fire_department,
              Colors.orange,
              '${DataService.getStreak(completedTodos).round()} Day',
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
              '${DataService.getThisWeekCount(completedTodos).round()} Completed',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Average',
              Icons.trending_up,
              Colors.teal,
              '${DataService.getAverageTasksPerDay(completedTodos).toStringAsFixed(1)} Tasks/Day',
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildStatsCard(String title, IconData icon, Color color, String value) {
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
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
