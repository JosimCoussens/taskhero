import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/calendar/calendar_service.dart';
import 'package:taskhero/data/leveling/level_service.dart';
import 'package:taskhero/data/leveling/xp_service.dart';
import 'package:taskhero/data/shop/item_service.dart';
import 'package:taskhero/data/user_service.dart';

class TodoService {
  static Future<List<Todo>> getAll() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(AppParams.userId)
            .collection('todos')
            .get();
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

  static Future<void> addTask(Todo newTask) async {
    if (AppParams.userId == null) throw Exception('User not logged in.');
    // Generate unique id
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    newTask.id = id;
    // Set the task in the database
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .collection('todos')
        .doc(id)
        .set(newTask.toMap());
    // Add the event to the calendar
    if (UserService.loggedInWithGoogle()) {
      await CalendarService.createEvent(newTask);
    }
  }

  static Future<int> toggleCompletion(Todo todo) async {
    // If the task is already completed, set it to not completed
    if (todo.isCompleted == true) {
      todo.isCompleted = false;
    }
    // Set task to completed and create new todo if it is a recurring task
    else {
      Todo todoToAdd = Todo.clone(todo);
      switch (todo.repeatCycle) {
        case 0: // No repeat
          todo.isCompleted = !todo.isCompleted;
          break;
        case 1: // Daily
          todoToAdd.date = todoToAdd.date.add(const Duration(days: 1));
          await addTask(todoToAdd);
          todo.isCompleted = !todo.isCompleted;
          break;
        case 2: // Weekly
          todoToAdd.date = todoToAdd.date.add(const Duration(days: 7));
          await addTask(todoToAdd);
          todo.isCompleted = !todo.isCompleted;
          break;
        case 3: // Monthly
          todoToAdd.date =
              todo.date.month < 12
                  ? DateTime(
                    todoToAdd.date.year,
                    todoToAdd.date.month + 1,
                    todoToAdd.date.day,
                  )
                  : DateTime(todoToAdd.date.year + 1, 1, todoToAdd.date.day);
          await addTask(todoToAdd);
          todo.isCompleted = !todo.isCompleted;
          break;
      }
    }
    // Update xp
    int addedXp = todo.isCompleted ? await _setXp(todo) : 0;
    // Delete event
    if (UserService.loggedInWithGoogle()) {
      await CalendarService.toggleStatus(todo.id!);
    }
    // Set completion date if task is completed
    todo.completionDate = todo.isCompleted ? DateTime.now() : null;
    // Update todo in database
    var todoFromDb = await _getTodo(todo.id!);
    await todoFromDb.update(todo.toMap());
    return addedXp;
  }

  static Future<int> _setXp(Todo todo) async {
    // Update xp
    int xpToAdd = 0;
    int baseXp = 50;
    switch (todo.difficulty) {
      case 0: // Easy
        xpToAdd = (baseXp * 0.5).ceil().toInt();
        break;
      case 1: // Medium
        xpToAdd = (baseXp * 1).toInt();
        break;
      case 2: // Hard
        xpToAdd = (baseXp * 2).ceil().toInt();
        break;
    }
    // Apply xp bonus from item
    var equippedItems = await ItemService.getEquipped();
    double totalBonusFromEquipped = 1;
    for (var item in equippedItems) {
      totalBonusFromEquipped += item.xpGain - 1;
    }
    xpToAdd = (xpToAdd * totalBonusFromEquipped).ceil().toInt();
    int newXp = AppParams.xp.value + xpToAdd;
    // Check if user leveled up and act accordingly
    int requiredXp = XpService.requiredXp();
    if (newXp >= requiredXp) {
      LevelService.setLevel(AppParams.level.value + 1);
      await XpService.setXp(newXp - requiredXp);
    } else {
      await XpService.setXp(newXp);
    }
    return xpToAdd;
  }

  static Future<DocumentReference<Map<String, dynamic>>> _getTodo(
    String todoId,
  ) async => FirebaseFirestore.instance
      .collection('users')
      .doc(AppParams.userId)
      .collection('todos')
      .doc(todoId.toString());

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

  static Future<void> delete(Todo todo, bool deleteEvent) async {
    // Delete the event from the calendar
    if (UserService.loggedInWithGoogle() && deleteEvent) {
      CalendarService.deleteEvent(todo.id!);
    }
    // Delete the todo from the database
    return _getTodo(todo.id!).then((doc) => doc.delete());
  }

  static Future<int> getTodoAmount(DateTime day) async {
    final todosSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(AppParams.userId)
            .collection('todos')
            .where('isCompleted', isEqualTo: false)
            .get();

    final todos = todosSnapshot.docs.where((todo) {
      final todoDate = todo['date'].toDate();
      return todoDate.year == day.year &&
          todoDate.month == day.month &&
          todoDate.day == day.day;
    });

    return todos.length;
  }

  static Future<List<Todo>> getAllCompleted() async {
    List<Todo> all = await getAll();
    return all.where((todo) => todo.isCompleted == true).toList();
  }

  Future<void> deleteCompleted() async {
    // Get all completed tasks
    var completedTasks = await getAllCompleted();
    // Delete each completed task
    for (var task in completedTasks) {
      await delete(task, false);
    }
  }
}
