// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/classes/todo.dart';

class TodoService {
  static Future<List<Todo>> getAll() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    return snapshot.docs
        .map((doc) => Todo.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Todo>> getTodays() async => getAll().then(
    (todos) =>
        todos
            .where(
              (todo) =>
                  todo.date.year == DateTime.now().year &&
                  todo.date.month == DateTime.now().month &&
                  todo.date.day == DateTime.now().day,
            )
            .toList(),
  );

  Future<List<Todo>> getPast() async => getAll().then(
    (todos) =>
        todos
            .where(
              (todo) =>
                  todo.isCompleted == false &&
                  todo.date.year <= DateTime.now().year &&
                  todo.date.month <= DateTime.now().month &&
                  todo.date.day < DateTime.now().day,
            )
            .toList(),
  );

  Future<List<Todo>> getTomorrows() async => getAll().then(
    (todos) =>
        todos
            .where(
              (todo) =>
                  todo.date.year == DateTime.now().year &&
                  todo.date.month == DateTime.now().month &&
                  todo.date.day == DateTime.now().day + 1,
            )
            .toList(),
  );

  Future<List<Todo>> getTodayCompleted() async => getAll().then(
    (todos) =>
        todos
            .where(
              (todo) =>
                  todo.isCompleted == true &&
                  todo.date.year == DateTime.now().year &&
                  todo.date.month == DateTime.now().month &&
                  todo.date.day == DateTime.now().day,
            )
            .toList(),
  );

  addTask(Todo newTask) async {
    FirebaseFirestore.instance.collection('todos').add(newTask.toMap());
  }

  static Future<List<Todo>> getCompletedTasks(DateTime day) {
    return getAll().then(
      (todos) =>
          todos
              .where(
                (todo) =>
                    todo.isCompleted == true &&
                    todo.date.year == day.year &&
                    todo.date.month == day.month &&
                    todo.date.day == day.day,
              )
              .toList(),
    );
  }

  static Future<List<Todo>> getUncompletedTasks(DateTime day) {
    return getAll().then(
      (todos) =>
          todos
              .where(
                (todo) =>
                    todo.isCompleted == false &&
                    todo.date.year == day.year &&
                    todo.date.month == day.month &&
                    todo.date.day == day.day,
              )
              .toList(),
    );
  }
}
