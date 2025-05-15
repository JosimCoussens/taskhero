import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/constants.dart';

class ItemService {
  static Future<List<Item>> getBoughtItems() {
    // get list from firebase
    return FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .get()
        .then((value) {
          List<int> inventory =
              (value.data()?['inventory'] as List<dynamic>)
                  .map((e) => e as int)
                  .toList();
          // get items from allItems
          return AppParams.allItems
              .where((item) => inventory.contains(item.id))
              .toList();
        });
  }

  static Future<void> buy(Item item) async {
    item.isPurchased = true;
    // get list from firebase
    List<int> inventory =
        (await FirebaseFirestore.instance
            .collection('user')
            .doc('properties')
            .get()
            .then(
              (value) => value.data()?['inventory'] as List<dynamic>,
            )).map((e) => e as int).toList();
    // add item to inventory
    inventory.add(item.id);
    // update firebase
    await FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .update({'inventory': inventory});
  }
}
