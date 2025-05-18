import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/item_service.dart';

// ignore: non_constant_identifier_names
Container ShopItem(Item item, Function onItemTransaction) {
  int sellPrice = (item.price / 2).floor();
  return Container(
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(item.imagePath, fit: BoxFit.contain),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.isPurchased ? sellPrice.toString() : item.price.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(AppParams.coinPath, width: 16, height: 16),
          ],
        ),
        if (item.isPurchased)
          _buildPurchaseButton(item, sellPrice, onItemTransaction),
        if (AppParams.money.value < item.price && !item.isPurchased)
          _showBuyRestriction(),
        if (AppParams.money.value >= item.price && !item.isPurchased)
          _buildPurchaseButton(item, sellPrice, onItemTransaction),
      ],
    ),
  );
}

Container _showBuyRestriction() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.redAccent, Colors.red],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [const Icon(Icons.lock, color: Colors.white, size: 16)],
    ),
  );
}

GestureDetector _buildPurchaseButton(
  Item item,
  int sellPrice,
  Function onItemTransaction,
) {
  return GestureDetector(
    onTap: () async {
      if (item.isPurchased) {
        await ItemService.sell(item, sellPrice);
        onItemTransaction();
      } else {
        await ItemService.buy(item);
        onItemTransaction();
      }
    },
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color:
            item.isPurchased
                ? AppColors.primaryLight
                : AppColors.primaryLighter,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        item.isPurchased ? 'Sell' : 'Buy',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
