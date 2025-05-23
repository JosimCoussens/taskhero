import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';

Widget equippedGear(List<Item> equippedItems) {
  List<ItemCategory> categories = ItemCategory.values.toList();

  return Container(
    margin: const EdgeInsets.only(bottom: AppParams.generalSpacing),
    padding: const EdgeInsets.all(AppParams.generalSpacing),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.primaryLight, width: 2),
    ),
    child: Column(
      spacing: AppParams.generalSpacing,
      children: [
        const Text(
          'Equipped Gear',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var category in categories)
              _ItemTile(category: category, items: equippedItems),
          ],
        ),
      ],
    ),
  );
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.category, required this.items});

  final ItemCategory category;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    var item = items.where((item) => item.category == category).firstOrNull;
    String? itembonus =
        item != null ? '+${((item.xpGain - 1) * 100).round()}% XP' : null;
    double imageSize = 80;
    double textSize = 20;
    return Column(
      children: [
        Text(
          category.name,
          style: TextStyle(color: Colors.white, fontSize: textSize),
        ),
        Column(
          children: [
            item != null
                ? Image.asset(
                  item.imagePath,
                  height: imageSize,
                  width: imageSize,
                )
                : Icon(
                  Icons.question_mark,
                  size: imageSize,
                  color: Colors.white,
                ),
            SizedBox(
              width: imageSize,
              height: textSize,
              child: FittedBox(
                child:
                    item != null
                        ? Text(
                          itembonus!,
                          style: const TextStyle(color: Colors.white),
                        )
                        : SizedBox(width: imageSize, height: textSize),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
