import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/core/classes/category.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback? toggleCompletion;
  final VoidCallback? dismis;

  const TodoWidget(this.todo, this.toggleCompletion, this.dismis, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.title + todo.date.toString()), // Use unique key
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        dismis?.call();
      },
      background: _dismissibleBackground(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            _checkmark(),
            const SizedBox(width: 12),
            _info(context),
            _category(),
          ],
        ),
      ),
    );
  }

  Container _category() {
    Category category = AppParams.categories.firstWhere(
      (cat) => cat.name == todo.category,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: category.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        todo.category,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Expanded _info(BuildContext context) {
    Category category = AppParams.categories.firstWhere(
      (cat) => cat.name == todo.category,
    );
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showTaskDetails(context, category);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (todo.repeatCycle > 0) ...[
                  const SizedBox(width: 8),
                  const Icon(Icons.repeat, color: Colors.white, size: 18),
                ],
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
    );
  }

  Future<dynamic> showTaskDetails(BuildContext context, Category category) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(todo.title),
          content: Column(
            spacing: AppParams.generalSpacing,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Description: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: todo.description,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Date: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: _formatDate(todo.date),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: category.color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    category.icon,
                    const SizedBox(width: AppParams.generalSpacing / 2),
                    Text(
                      todo.category,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector _checkmark() {
    return GestureDetector(
      onTap: () => toggleCompletion?.call(),
      child: Icon(
        todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
        color: Colors.white,
        size: 24,
      ),
    );
  }

  Container _dismissibleBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 20),
      color: Colors.red,
      child: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white, size: 32),
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
