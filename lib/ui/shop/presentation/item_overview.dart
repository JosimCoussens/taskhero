import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/item_service.dart';
import 'package:taskhero/ui/shop/presentation/item/shop_item.dart';

SizedBox buildInventory(
  BuildContext context,
  List<Item> items,
  List<Item> equippedItems,
  VoidCallback onEquipped,
) {
  // Configuration for grid layout
  final int amountPerRow = 4;
  late double itemWidth;

  // Track which items are bought
  List<ItemCategory> categories = ItemService.getCategories();

  // Calcute item width
  double spacing = AppParams.generalSpacing;
  double totalSpacing = spacing * (amountPerRow - 1);
  itemWidth =
      (MediaQuery.of(context).size.width -
          (AppParams.generalSpacing * 2) -
          totalSpacing) /
      amountPerRow;

  return SizedBox(
    width: double.infinity,
    child: SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          spacing: AppParams.generalSpacing,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              categories.map((category) {
                var categoryItems =
                    items.where((item) => item.category == category).toList();
                var equippedCategoryItems =
                    categoryItems
                        .where((item) => equippedItems.contains(item))
                        .toList();
                bool isLastCategory = category == categories.last;
                return Padding(
                  // Give it padding at the bottom
                  padding: EdgeInsets.only(
                    bottom: isLastCategory ? AppParams.generalSpacing * 2 : 0,
                  ),
                  child: buildCategorySection(
                    category,
                    categoryItems,
                    equippedCategoryItems,
                    itemWidth,
                    onEquipped,
                    context,
                  ),
                );
              }).toList(),
        ),
      ),
    ),
  );
}

BoxDecoration showBackgroundImage() {
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/armoury.png'),
      colorFilter: AppParams.backgroundImageColorFilter,
      fit: BoxFit.cover,
    ),
  );
}

Column buildCategorySection(
  ItemCategory category,
  List<Item> categoryItems,
  List<Item> equippedCategoryItems,
  double itemWidth,
  VoidCallback onEquipped,
  BuildContext context,
) {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppParams.generalSpacing / 2,
          children: [
            buildCategoryName(category),
            buildCategoryItems(
              categoryItems,
              equippedCategoryItems,
              itemWidth,
              onEquipped,
              context,
            ),
          ],
        ),
      ),
    ],
  );
}

Wrap buildCategoryItems(
  List<Item> categoryItems,
  List<Item> equippedCategoryItems,
  double itemWidth,
  VoidCallback onEquipped,
  BuildContext context,
) {
  return Wrap(
    spacing: AppParams.generalSpacing / 2,
    runSpacing: AppParams.generalSpacing / 2,
    alignment: WrapAlignment.start,
    children: [
      ...categoryItems.map((item) {
        bool isEquipped = equippedCategoryItems.contains(item);
        return ShopItem(item, itemWidth, onEquipped, context, isEquipped);
      }),
    ],
  );
}

Stack buildCategoryName(ItemCategory category) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
      ),
      Center(
        child: Text(
          category.name,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
