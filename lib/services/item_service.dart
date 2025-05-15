import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/user_service.dart';

class ItemService {
  static Future<void> setAppItems() async {
    var boughtItems = await ItemService.getBoughtItems();
    for (var item in AppParams.allItems) {
      item.isPurchased = boughtItems.any((bought) => bought.id == item.id);
    }
  }

  static Future<List<Item>> getBoughtItems() {
    // get list from firebase
    return FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .get()
        .then((value) {
          List<Item> items = [];
          for (var id in value.data()!['inventory']) {
            items.add(AppParams.allItems.firstWhere((i) => i.id == id));
          }
          return items;
        });
  }

  static Future<bool> buy(Item item) async {
    if (AppParams.xp.value < item.price) {
      return false;
    }
    AppParams.allItems.where((i) => i.id == item.id).first.isPurchased = true;
    // Update firebase
    await FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .update({
          'inventory':
              AppParams.allItems
                  .where((i) => i.isPurchased)
                  .map((e) => e.id)
                  .toList(),
        });
    // Update xp
    UserService.setXp(AppParams.xp.value - item.price);
    return true;
  }

  static Future<void> sell(Item item, int sellprice) async {
    AppParams.allItems.where((i) => i.id == item.id).first.isPurchased = false;
    await FirebaseFirestore.instance
        .collection('user')
        .doc('properties')
        .update({
          'inventory':
              AppParams.allItems
                  .where((i) => i.isPurchased)
                  .map((e) => e.id)
                  .toList(),
        });
    // Update xp
    UserService.setXp(AppParams.xp.value + sellprice);
  }
}
