import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/constants.dart';

class XpService {
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

  static int requiredXp() {
    int level = AppParams.level.value + 1;
    double exponent = 1.5;
    int base = 100;
    return (base * pow(level, exponent)).round();
  }
}
