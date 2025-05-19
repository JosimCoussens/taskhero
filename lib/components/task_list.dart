import 'package:flutter/widgets.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/todo_widget.dart';
import 'package:taskhero/services/todo_service.dart';

Expanded showTaskList(List<Todo> todos, Function refreshList) {
  return Expanded(
    child: ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Column(
          children: [
            TodoWidget(
              todo,
              () async {
                await TodoService.toggleCompletion(todo);
              },
              () async {
                todos.remove(todo);
                await TodoService.delete(todo);
                refreshList();
              },
            ),
          ],
        );
      },
    ),
  );
}
