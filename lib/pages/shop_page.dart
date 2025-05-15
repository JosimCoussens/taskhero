import 'package:flutter/material.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/item_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final int amountPerRow = 4;
  final double spacing = 5;
  late double itemWidth;

  Map<String, List<Item>> categorizedItems = {};
  List<Widget> sectionWidgets = [];

  @override
  void initState() {
    super.initState();
    // Organize items by category
    for (Item item in AppParams.allItems) {
      String category = item.category.name;
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalSpacing = spacing * (amountPerRow - 1);
    itemWidth =
        (MediaQuery.of(context).size.width -
            (AppParams.generalSpacing * 2) -
            totalSpacing) /
        amountPerRow;
    sectionWidgets = [];
    for (var category in ['Weapons', 'Armour', 'Shields']) {
      if (categorizedItems.containsKey(category) &&
          categorizedItems[category]!.isNotEmpty) {
        sectionWidgets.add(
          _buildSection(category, categorizedItems[category] ?? [], () {
            setState(() {});
          }),
        );
      }
    }

    return Scaffold(
      appBar: AppHeader(title: "Shop"),
      body: _showContent(),
      bottomNavigationBar: bottomAppBar(context, () {
        setState(() {});
      }),
    );
  }

  void refresh() {
    setState(() {});
  }

  Container _showContent() {
    return Container(
      padding: const EdgeInsets.all(AppParams.generalSpacing),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/market.png'),
          colorFilter: AppParams.backgroundImageColorFilter,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Rest of the UI - Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: sectionWidgets),
            ),
          ),
        ],
      ),
    );
  }

  // Build a section with title and items
  Widget _buildSection(
    String title,
    List<Item> items,
    Function onItemTransaction,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section header
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.primaryLight, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.circle, color: AppColors.primaryLight, size: 24),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Icon(Icons.circle, color: AppColors.primaryLight, size: 24),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Items grid
        if (items.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: amountPerRow,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              childAspectRatio:
                  itemWidth / (itemWidth * 1.3), // Adjust for item height
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildShopItem(items[index], onItemTransaction);
            },
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Build a shop item (weapon, armor, etc.)
  Widget _buildShopItem(Item item, Function onItemTransaction) {
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
              const Icon(Icons.circle, color: Colors.amber, size: 16),
            ],
          ),
          if (AppParams.xp.value >= item.price)
            _buildPurchaseButton(item, sellPrice, onItemTransaction),
          if (AppParams.xp.value < item.price) _showBuyRestriction(),
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
          refresh();
        } else {
          await ItemService.buy(item);
          refresh();
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
}
