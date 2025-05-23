import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/ui/todo/presentation/todo_widget.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';

Expanded showTaskList(List<Todo> todos, Function refreshList) {
  return Expanded(
    child: ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Column(
          children: [
            TodoWidget(
              todo,
              () async {
                int addedXp = await TodoService.toggleCompletion(todo);
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(_showXpgainDialog(addedXp));
                }
                refreshList();
              },
              () async {
                todos.remove(todo);
                refreshList();
                await TodoService.delete(todo, true);
              },
            ),
            if (index != todos.length - 1)
              const SizedBox(height: AppParams.generalSpacing / 2),
          ],
        );
      },
    ),
  );
}

SnackBar _showXpgainDialog(int addedXp) {
  return SnackBar(
    content: Text('You gained $addedXp XP!'),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    backgroundColor: AppColors.primaryLight,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}
