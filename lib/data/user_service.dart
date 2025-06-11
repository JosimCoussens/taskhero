import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/constants.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    // Check if the user already exists
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    if (userDoc.exists) {
      return;
    }
    // Create a new user document with default values
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'xp': 0,
      'level': 0,
    });
  }

  static bool loggedInWithGoogle() {
    return AppParams.loginMethod == "google.com" ? true : false;
  }
}
