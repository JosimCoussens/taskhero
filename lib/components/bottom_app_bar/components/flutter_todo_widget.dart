import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/constants.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A4976),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              todo.isCompleted ? Icons.circle : Icons.circle_outlined,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 16),

            // Task details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    todo.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Date
                  Text(
                    _formatDate(todo.date),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Category indicator
            _buildCategoryIndicator(todo.category),

            const SizedBox(width: 8),

            // Priority indicator
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                border: Border.all(color: AppColors.primaryLight, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flag_outlined, color: Colors.white),
                    Text(
                      todo.priority.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIndicator(String category) {
    IconData icon;
    Color backgroundColor;

    // Set icon and color based on category
    switch (category.toLowerCase()) {
      case 'home':
        icon = Icons.home;
        backgroundColor = const Color(0xFFE94E4F);
        break;
      case 'work':
        icon = Icons.work;
        backgroundColor = const Color(0xFF4CAF50);
        break;
      case 'study':
        icon = Icons.book;
        backgroundColor = const Color(0xFF2196F3);
        break;
      default:
        icon = Icons.list;
        backgroundColor = const Color(0xFFFF9800);
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day + 1) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM d, HH:mm').format(date);
    }
  }
}
