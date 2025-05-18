import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class UserService {
  static Future<void> createUser(String userUid) async {
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'money': 50,
      'xp': 0,
      'inventory': [],
    });
  }

  static Future<int> getMoney() async {
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();
    return data?['money'] ?? (throw Exception('Document does not exist'));
  }

  static Future<void> setMoney(int money) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({'money': money});
    AppParams.money.value = money;
  }
}
