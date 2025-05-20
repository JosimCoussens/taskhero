import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/constants.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'money': 50,
      'xp': 0,
      'inventory': [],
      'level': 0,
    });
  }

  static bool loggedInWithGoogle() {
    return AppParams.loginMethod == "google.com" ? true : false;
  }
}
