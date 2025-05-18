import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class MoneyService {
  static Future<int> getMoney() async {
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();
    int money = data?['money'] ?? (throw Exception('Document does not exist'));
    AppParams.money.value = money;
    return money;
  }

  static Future<void> setMoney(int money) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({'money': money});
    AppParams.money.value = money;
  }
}
