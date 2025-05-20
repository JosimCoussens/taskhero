import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/money_service.dart';

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
        .collection('users')
        .doc(AppParams.userId)
        .get()
        .then((value) {
          List<Item> items = [];
          for (var id in value.data()!['inventory']) {
            items.add(AppParams.allItems.firstWhere((i) => i.id == id));
          }
          return items;
        });
  }

  static Future<void> buy(Item item) async {
    if (AppParams.money.value < item.price) return;
    AppParams.allItems.where((i) => i.id == item.id).first.isPurchased = true;
    // Update firebase
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({
          'inventory':
              AppParams.allItems
                  .where((i) => i.isPurchased)
                  .map((e) => e.id)
                  .toList(),
        });
    // Update money
    await MoneyService.setMoney(AppParams.money.value - item.price);
  }

  static Future<void> sell(Item item, int sellprice) async {
    AppParams.allItems.where((i) => i.id == item.id).first.isPurchased = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({
          'inventory':
              AppParams.allItems
                  .where((i) => i.isPurchased)
                  .map((e) => e.id)
                  .toList(),
        });
    // Update xp
    await MoneyService.setMoney(AppParams.money.value + sellprice);
  }
}
