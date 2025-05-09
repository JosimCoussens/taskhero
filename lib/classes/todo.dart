class Todo {
  String title;
  String description;

  Todo({required this.title, this.description = ''});

  // Factory method to create a Todo from Firestore document data
  factory Todo.fromFirestore(Map<String, dynamic> data) {
    return Todo(
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }

  // Convert Todo instance back to a map (if needed for storing in Firestore)
  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description};
  }
}
