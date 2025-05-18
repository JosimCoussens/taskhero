import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class UserService {
  static Future<int> getXp() async {
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();
    return data?['xp'] ?? (throw Exception('Document does not exist'));
  }

  static Future<void> setXp(int xp) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({'xp': xp});
    AppParams.xp.value = xp;
  }
}
