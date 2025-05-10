import 'package:flutter/material.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // Configuration for grid layout
  final int amountPerRow = 4;
  final double spacing = 5;
  late double itemWidth;

  // Track which items are bought
  List<Item> boughtItems = [
    Item(
      id: 1,
      name: 'Axe',
      category: 'Weapons',
      imagePath: 'assets/images/axe.png',
      isPurchased: true,
      price: 20,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 2,
      name: 'Helmet 3',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_3.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 3,
      name: 'Helmet 2',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_2.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 4,
      name: 'Shield 1',
      category: 'Shields',
      imagePath: 'assets/images/shields/shield_1.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 5,
      name: 'Silver Sword',
      category: 'Weapons',
      imagePath: 'assets/images/sword.png',
      isPurchased: true,
      price: 25,
    ),
    Item(
      id: 6,
      name: 'Helmet 1',
      category: 'Armour',
      imagePath: 'assets/images/helmets/helmet_1.png',
      isPurchased: true,
      price: 10,
    ),
  ];

  Map<String, List<Item>> categorizedItems = {};
  List<Widget> sectionWidgets = [];

  @override
  void initState() {
    super.initState();
    // Organize items by category
    for (Item item in boughtItems) {
      String category = item.category;
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate item width based on screen size
    double totalSpacing = spacing * (amountPerRow - 1);
    itemWidth =
        (MediaQuery.of(context).size.width -
            (AppParams.generalSpacing * 2) -
            totalSpacing) /
        amountPerRow;

    // Build section widgets here instead of initState to ensure itemWidth is calculated
    sectionWidgets = [];
    for (var category in ['Weapons', 'Armour', 'Shields']) {
      if (categorizedItems.containsKey(category) &&
          categorizedItems[category]!.isNotEmpty) {
        sectionWidgets.add(
          _buildSection(category, categorizedItems[category] ?? []),
        );
      }
    }

    return Scaffold(
      appBar: header(),
      body: _showContent(),
      bottomNavigationBar: bottomAppBar(context),
    );
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
  Widget _buildSection(String title, List<Item> items) {
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
              return _buildShopItem(
                items[index].name,
                items[index].imagePath,
                items[index].price,
              );
            },
          ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Build a shop item (weapon, armor, etc.)
  Widget _buildShopItem(String id, String imagePath, int price) {
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
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$price',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.circle, color: Colors.amber, size: 16),
            ],
          ),
          GestureDetector(
            onTap: () {
              // Implement sell functionality
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryLighter,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: const Text(
                'Sell',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
