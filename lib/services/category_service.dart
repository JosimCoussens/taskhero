import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/classes/category.dart';

class CategoryService {
  static getAll() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    return snapshot.docs
        .map(
          (doc) => Category.fromFirestore(doc.data() as Map<String, dynamic>),
        )
        .toList();
  }

  static addCategory(Category newCategory) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    newCategory.id = id;
    FirebaseFirestore.instance
        .collection('categories')
        .doc(id)
        .set(newCategory.toMap());
  }
}
