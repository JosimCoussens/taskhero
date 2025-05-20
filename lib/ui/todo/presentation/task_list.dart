import 'package:flutter/widgets.dart';
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
                await TodoService.toggleCompletion(todo);
                refreshList();
              },
              () async {
                todos.remove(todo);
                refreshList();
                await TodoService.delete(todo);
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
