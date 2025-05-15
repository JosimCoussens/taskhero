import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class UserService {
  static Future<int> getXp() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('user')
            .doc('properties')
            .get();

    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data();
      if (data != null && data.containsKey('xp')) {
        return data['xp'] as int;
      }
    }
    throw Exception('Document does not exist');
  }

  static Future<void> setXp(int xp) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .update({'xp': xp});
    AppParams.xp.value = xp;
  }
}
