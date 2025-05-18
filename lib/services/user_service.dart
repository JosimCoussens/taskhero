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
