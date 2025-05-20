import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/constants.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'xp': 0,
      'level': 0,
    });
  }

  static bool loggedInWithGoogle() {
    return AppParams.loginMethod == "google.com" ? true : false;
  }
}
