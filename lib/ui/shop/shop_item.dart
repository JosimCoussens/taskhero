import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/shop/item_service.dart';

// ignore: non_constant_identifier_names
Container ShopItem(Item item, double itemWidth, VoidCallback onEquipped) {
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: imageHeight,
              child: Image.asset(item.imagePath, fit: BoxFit.contain),
            ),
          ),
          _buildUnlockedSection(bottomHeight, item, onEquipped),
        ],
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
                      ? Text(
                        isEquipped ? 'Unequip' : 'Equip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Row(
                        children: [
                          Text(
                            'Level ${item.levelRequirement}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.lock, color: Colors.white, size: 16),
                        ],
                      ),
            ),
          ),
        ),
      );
    },
  );
}
