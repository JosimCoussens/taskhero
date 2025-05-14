import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/constants.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final void Function()? toggleCompletion;

  const TodoWidget(this.todo, this.toggleCompletion, {super.key});

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
          GestureDetector(
            onTap: () {
              toggleCompletion!();
            },
            child: Icon(
              todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (todo.repeatCycle > 0)
                      Icon(Icons.repeat, color: Colors.white, size: 18),
                  ],
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
        ],
      ),
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
