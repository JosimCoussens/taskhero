import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String title;
  String description;
  DateTime date;
  String category;
  int priority;
  bool isCompleted;
  int repeatCycle;

  Todo({
    required this.title,
    this.description = '',
    DateTime? date,
    this.category = 'General',
    this.priority = 1,
    this.isCompleted = false,
    this.repeatCycle = 0,
  }) : date = date ?? DateTime.now();

  // Factory method to create a Todo from Firestore document data
  factory Todo.fromFirestore(Map<String, dynamic> data) {
    return Todo(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] ?? 'General',
      priority: data['priority'] ?? 1,
      isCompleted: data['isCompleted'] ?? false,
      repeatCycle: data['repeatCycle'] ?? 0,
    );
  }

  // Convert Todo instance back to a map (if needed for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
