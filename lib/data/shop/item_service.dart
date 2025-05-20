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
}
