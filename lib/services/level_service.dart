import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class LevelService {
  static Future<int> getLevel() async {
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();
    return data?['level'] ?? (throw Exception('Document does not exist'));
  }

  static Future<void> setLevel(int level) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({'level': level});
  }
}
