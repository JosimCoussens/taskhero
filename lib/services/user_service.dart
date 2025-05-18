import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'money': 50,
      'xp': 0,
      'inventory': [],
    });
  }
}
