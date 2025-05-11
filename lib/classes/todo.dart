import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String title;
  String description;
  DateTime date;
  String category;
  bool isCompleted;
  int repeatCycle;
  int difficulty;

  Todo({
    required this.title,
    this.description = '',
    DateTime? date,
    this.category = 'General',
    this.isCompleted = false,
    this.repeatCycle = 0,
    this.difficulty = 1,
  }) : date = date ?? DateTime.now();

  // Factory method to create a Todo from Firestore document data
  factory Todo.fromFirestore(Map<String, dynamic> data) {
    return Todo(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] ?? 'General',
      isCompleted: data['isCompleted'] ?? false,
      repeatCycle: data['repeatCycle'] ?? 0,
      difficulty: data['difficulty'] ?? 1,
    );
  }

  // Convert Todo instance back to a map (if needed for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'category': category,
      'isCompleted': isCompleted,
      'repeatCycle': repeatCycle,
      'difficulty': difficulty,
    };
  }
}
