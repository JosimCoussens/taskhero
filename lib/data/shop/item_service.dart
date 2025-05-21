import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';

class ItemService {
  static List<Item> getUnlockedItems() {
    return AppParams.allItems
        .where((item) => item.levelRequirement <= AppParams.level.value)
        .toList();
  }

  static bool isUnlocked(Item item) {
    return AppParams.level.value >= item.levelRequirement;
  }

  static List<Item> getAtLevel(int level) {
    return AppParams.allItems
        .where((item) => item.levelRequirement == level)
        .toList();
  }

  static List<ItemCategory> getCategories() {
    return AppParams.allItems.map((item) => item.category).toSet().toList();
  }

  static List<Item> getUnlockedItemsByCategory(ItemCategory category) {
    return AppParams.allItems
        .where(
          (item) =>
              item.levelRequirement <= AppParams.level.value &&
              item.category == category,
        )
        .toList();
  }

  static List<Item> getItemsByCategory(ItemCategory category) {
    return AppParams.allItems
        .where((item) => item.category == category)
        .toList();
  }

  static Item? getById(int id) {
    return AppParams.allItems.where((item) => item.id == id).firstOrNull;
  }

  static Future<List<Item>> getEquipped() async {
    // Get raw data from the database
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();

    if (data?['equippedItems'] == null) {
      return [];
    }
    // Parse the data to a list of integers
    List<int> equippedItemIds = List<int>.from(
      data!['equippedItems'].map((item) => int.parse(item.toString())),
    );
    // Get the equipped items from the allItems list and return as parsed.
    List<Item> equippedItems = [];
    for (var item in equippedItemIds) {
      Item? i = getById(item);
      if (i != null) {
        equippedItems.add(i);
      }
    }
    return equippedItems;
  }

  static Future<void> unequip(Item item) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({
          DatabaseParams.equippedTableName: FieldValue.arrayRemove([item.id]),
        });
  }

  static Future<bool> isEquipped(Item item) async {
    // Check if item is unlocked
    if (!isUnlocked(item)) {
      return false;
    }
    // Get raw data from the database
    var data =
        (await FirebaseFirestore.instance
                .collection('users')
                .doc(AppParams.userId)
                .get())
            .data();

    if (data?[DatabaseParams.equippedTableName] == null) {
      return false;
    }
    // Parse the data to a list of integers
    List<int> equippedItemIds = List<int>.from(
      data![DatabaseParams.equippedTableName].map(
        (item) => int.parse(item.toString()),
      ),
    );
    return equippedItemIds.contains(item.id);
  }

  static Future<void> equip(Item item) async {
    // Get and remove items of same category from database
    String category = item.category.toString();
    var equippedItems = await getEquipped();
    var equippedItemsOfSameCategory =
        equippedItems.where((i) => i.category.toString() == category).toList();
    for (var i in equippedItemsOfSameCategory) {
      await unequip(i);
    }
    // Set the task in the database
    await FirebaseFirestore.instance
        .collection('users')
        .doc(AppParams.userId)
        .update({
          DatabaseParams.equippedTableName: FieldValue.arrayUnion([item.id]),
        });
  }
}
