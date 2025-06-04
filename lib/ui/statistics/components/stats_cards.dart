import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/data_service.dart';
import 'package:taskhero/data/todo_service.dart';

Widget statsCards(List<Todo> completedTodos) {
  return completedTodos.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : _showCards(completedTodos);
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
              completedTodos.length,
              null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Streak',
              Icons.local_fire_department,
              Colors.orange,
              DataService.getStreak(completedTodos),
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
              TodoService.getThisWeekCount(completedTodos),
              ' Tasks',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatsCard(
              'Average',
              Icons.trending_up,
              Colors.teal,
              -1,
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
  int value,
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
        Text(
          value.toString() + (postText ?? ''),
          style: const TextStyle(
            fontSize: 24,
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
