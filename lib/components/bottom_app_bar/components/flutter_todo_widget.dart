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
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _formatDate(todo.date),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: todo.category == 'General' ? Colors.green : Colors.pink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              todo.category,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          if (todo.priority > 0)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  const Icon(Icons.flag, color: Colors.white, size: 16),
                  const SizedBox(width: 2),
                  Text(
                    todo.priority.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
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
