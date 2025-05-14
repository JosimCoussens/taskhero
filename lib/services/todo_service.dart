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
    // Generate unique id
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    newTask.id = id;
    FirebaseFirestore.instance.collection('todos').doc(id).set(newTask.toMap());
  }

  static Future<void> toggleCompletion(Todo todo) async {
    if (todo.isCompleted == true) {
      todo.isCompleted = false;
    } else {
      switch (todo.repeatCycle) {
        case 0: // No repeat
          todo.isCompleted = !todo.isCompleted;
          break;
        case 1: // Daily
          todo.date = todo.date.add(const Duration(days: 1));
          break;
        case 2: // Weekly
          todo.date = todo.date.add(const Duration(days: 7));
          break;
        case 3: // Monthly
          todo.date =
              todo.date.month < 12
                  ? DateTime(todo.date.year, todo.date.month + 1, todo.date.day)
                  : DateTime(todo.date.year + 1, 1, todo.date.day);
          break;
      }
    }
    // Update and save the todo
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todo.id)
        .update(todo.toMap());
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

  static Future<List<Todo>> getAllUncompleted() async {
    List<Todo> todos = await getAll();
    todos = todos.where((todo) => todo.isCompleted == false).toList();
    todos.sort((a, b) => a.date.compareTo(b.date));
    return todos;
  }
}
