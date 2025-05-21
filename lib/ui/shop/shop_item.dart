import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/item_service.dart';

// ignore: non_constant_identifier_names
Container ShopItem(
  Item item,
  double itemWidth,
  VoidCallback onEquipped,
  BuildContext context,
) {
  double imageHeight = 80;
  double bottomHeight = 30;

  return Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: SizedBox(
      width: itemWidth,
      height:
          imageHeight + bottomHeight + 24, // 24 = padding (12 top + 12 bottom)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildImageSection(imageHeight, item, context),
          _buildUnlockedSection(bottomHeight, item, onEquipped),
        ],
      ),
    ),
  );
}

Widget _buildImageSection(double imageHeight, Item item, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // Show a popup with item details
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  item.imagePath,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  'Bonus Effect: XP gained +${((item.xpGain - 1) * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: const Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(AppParams.generalSpacing / 2),
      child: SizedBox(
        height: imageHeight,
        child: Image.asset(item.imagePath, fit: BoxFit.contain),
      ),
    ),
  );
}

Widget _buildUnlockedSection(
  double height,
  Item item,
  VoidCallback onEquipped,
) {
  var isUnlocked = ItemService.isUnlocked(item);
  return FutureBuilder(
    future: ItemService.isEquipped(item),
    builder: (context, snapshot) {
      final isEquipped = snapshot.data ?? false;
      return GestureDetector(
        onTap: () async {
          if (isEquipped) {
            await ItemService.unequip(item);
            onEquipped();
          } else {
            await ItemService.equip(item);
            onEquipped();
          }
        },
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isUnlocked ? AppColors.primaryLight : Colors.red,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: FittedBox(
              child:
                  isUnlocked
                      ? _unlockedButtonSection(isEquipped)
                      : _lockedButtonSection(item),
            ),
          ),
        ),
      );
    },
  );
}

Row _lockedButtonSection(Item item) {
  return Row(
    children: [
      Text(
        'Level ${item.levelRequirement}',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 4),
      Icon(Icons.lock, color: Colors.white, size: 16),
    ],
  );
}

Icon _unlockedButtonSection(bool isEquipped) {
  return Icon(
    isEquipped ? Icons.check_circle : Icons.add_circle_outline,
    color: isEquipped ? Colors.greenAccent : Colors.white,
    size: 18,
  );
}
