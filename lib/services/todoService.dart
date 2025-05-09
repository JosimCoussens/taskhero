// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/classes/todo.dart';

class TodoService {
  Future<List<Todo>> getAll() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('todos').get();

    return snapshot.docs
        .map((doc) => Todo.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
