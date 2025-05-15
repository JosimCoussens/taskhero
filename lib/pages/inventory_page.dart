import 'package:flutter/material.dart';
import 'package:taskhero/classes/item.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/bottom_app_bar/components/styles.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/pages/shop_page.dart';
import 'package:taskhero/services/item_service.dart';

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
  List<Item> boughtItems = [];

  Map<String, List<Item>> categorizedItems = {};
  List<Widget> sectionWidgets = [];

  @override
  void initState() {
    fetchBoughtItems();
    super.initState();
    // Organize items by category
    for (Item item in boughtItems) {
      String category = item.category.name;
      if (!categorizedItems.containsKey(category)) {
        categorizedItems[category] = [];
      }
      categorizedItems[category]!.add(item);
    }
  }

  Future<void> fetchBoughtItems() async {
    List<Item> itemsTemp = await ItemService.getBoughtItems();

    // Rebuild categorized items and sections
    Map<String, List<Item>> newCategorizedItems = {};
    List<Widget> newSectionWidgets = [];

    for (var item in itemsTemp) {
      String category = item.category.name;
      if (!newCategorizedItems.containsKey(category)) {
        newCategorizedItems[category] = [];
      }
      newCategorizedItems[category]!.add(item);
    }

    for (ItemCategory category in ItemCategory.values) {
      String categoryName = category.name;
      if (newCategorizedItems.containsKey(categoryName) &&
          newCategorizedItems[categoryName]!.isNotEmpty) {
        newSectionWidgets.add(
          _buildSection(categoryName, newCategorizedItems[categoryName]!),
        );
      }
    }

    setState(() {
      boughtItems = itemsTemp;
      categorizedItems = newCategorizedItems;
      sectionWidgets = newSectionWidgets;
    });
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
    for (ItemCategory category in ItemCategory.values) {
      String categoryName = category.name;
      if (categorizedItems.containsKey(categoryName) &&
          categorizedItems[categoryName]!.isNotEmpty) {
        sectionWidgets.add(
          _buildSection(categoryName, categorizedItems[categoryName] ?? []),
        );
      }
    }

    return Scaffold(
      appBar: AppHeader(title: 'Inventory'),
      body: _showContent(),
      bottomNavigationBar: bottomAppBar(context, () {
        setState(() {});
      }),
    );
  }

  Container _showContent() {
    return Container(
      padding: const EdgeInsets.all(AppParams.generalSpacing),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/armoury.png'),
          colorFilter: AppParams.backgroundImageColorFilter,
          fit: BoxFit.cover,
        ),
      ),
      child:
          boughtItems.isEmpty
              ? _buildEmptyInventoryMessage()
              : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: sectionWidgets),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildEmptyInventoryMessage() {
    return Expanded(
      child: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No items in your inventory.',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Visit the market to buy weapons, armour or shields!',
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopPage()),
                );
              },
              style: Styles().goToPageButtonStyle,
              child: const Text(
                'Go to Market',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
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
