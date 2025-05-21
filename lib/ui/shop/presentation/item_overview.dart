import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/item_service.dart';
import 'package:taskhero/ui/shop/presentation/item/shop_item.dart';

Container showContent(
  BuildContext context,
  List<Item> items,
  Function onEmpty,
  String backgroundImagePath,
  VoidCallback onEquipped,
) {
  return Container(
    padding: const EdgeInsets.only(
      top: AppParams.generalSpacing,
      left: AppParams.generalSpacing,
      right: AppParams.generalSpacing,
    ),
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(backgroundImagePath),
        colorFilter: AppParams.backgroundImageColorFilter,
        fit: BoxFit.cover,
      ),
    ),
    child:
        items.isEmpty ? onEmpty() : buildInventory(context, items, onEquipped),
  );
}

SizedBox buildInventory(
  BuildContext context,
  List<Item> items,
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
    height: double.infinity,
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
                bool isLastCategory = category == categories.last;
                return Padding(
                  // Give it padding at the bottom
                  padding: EdgeInsets.only(
                    bottom: isLastCategory ? AppParams.generalSpacing * 2 : 0,
                  ),
                  child: buildCategorySection(
                    category,
                    categoryItems,
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

Column buildCategorySection(
  ItemCategory category,
  List<Item> categoryItems,
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
            buildCategoryItems(categoryItems, itemWidth, onEquipped, context),
          ],
        ),
      ),
    ],
  );
}

Wrap buildCategoryItems(
  List<Item> categoryItems,
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
        return ShopItem(item, itemWidth, onEquipped, context);
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
