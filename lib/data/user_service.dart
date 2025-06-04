import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/auth/auth.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'xp': 0,
      'level': 0,
      'dayStatistics': [0, 0, 0, 0, 0, 0, 0],
    });
  }

  static Future<void> updateDayStats(int day) async {
    var stats = await getDayStatsList();
    stats[day] += 1;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Auth().currentUser!.uid)
        .update({'dayStatistics': stats});
  }

  static Future<List<int>> getDayStatsList() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Auth().currentUser!.uid)
        .get()
        .then((snapshot) {
          List<int> dayStats = List<int>.from(
            snapshot.data()!['dayStatistics'],
          );
          return dayStats;
        });
  }

  static Future<int> getDayStats(int day) async {
    var list = await getDayStatsList();
    return list[day];
  }

  static bool loggedInWithGoogle() {
    return AppParams.loginMethod == "google.com" ? true : false;
  }
}
