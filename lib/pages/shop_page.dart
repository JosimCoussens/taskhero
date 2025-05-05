import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/main.dart';
import 'package:taskhero/pages/home_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Track which items are bought
  Map<String, bool> _boughtItems = {};

  @override
  void initState() {
    super.initState();
    // Initialize some items as bought for demo
    _boughtItems = {
      'axe': true, // The middle weapon is bought
      'helmet3': true, // One of the helmets is bought
    };
  }

  // Toggle bought status
  void _toggleBuyStatus(String itemId) {
    setState(() {
      _boughtItems[itemId] = !(_boughtItems[itemId] ?? false);
    });
  }

  // Check if an item is bought
  bool _isBought(String itemId) {
    return _boughtItems[itemId] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: _showContent(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  Container _showContent() {
    return Container(
      padding: const EdgeInsets.all(AppParams.generalSpacing),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/market.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Rest of the UI - Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Weapons Section
                  _buildSection('Weapons', [
                    _buildShopItem('sword', 'assets/images/sword.png', 15),
                    _buildShopItem('axe', 'assets/images/axe.png', 15),
                    _buildShopItem('bow', 'assets/images/bow.png', 15),
                  ]),

                  // Armour Section - First Row
                  _buildSection('Armour', [
                    _buildShopItem(
                      'helmet1',
                      'assets/images/helmets/helmet_1.png',
                      15,
                    ),
                    _buildShopItem(
                      'helmet2',
                      'assets/images/helmets/helmet_2.png',
                      15,
                    ),
                    _buildShopItem(
                      'helmet3',
                      'assets/images/helmets/helmet_3.png',
                      15,
                    ),
                    _buildShopItem(
                      'helmet4',
                      'assets/images/helmets/helmet_4.png',
                      15,
                    ),
                  ]),
                  // Shields Section
                  _buildSection('Shields', []),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a section with title and items
  Widget _buildSection(String title, List<Widget> items) {
    int amountPerRow = 4;
    double spacing = 5;
    double totalSpacing = spacing * (amountPerRow - 1);
    double itemWidth =
        ((MediaQuery.of(context).size.width - (AppParams.generalSpacing * 2)) -
            totalSpacing) /
        amountPerRow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.primaryLight, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Expanded(
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
        ),
        if (items.isNotEmpty)
          Row(
            children: List.generate(
              items.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  top: spacing * 2,
                  bottom: spacing * 2,
                  right:
                      (index % amountPerRow != amountPerRow - 1) ? spacing : 0,
                ),
                child: SizedBox(width: itemWidth, child: items[index]),
              ),
            ),
          ),
      ],
    );
  }

  // Build a shop item (weapon, armor, etc.)
  Widget _buildShopItem(String id, String imagePath, int price) {
    bool bought = _isBought(id);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(imagePath, height: 60),
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
            onTap: () => _toggleBuyStatus(id),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color:
                    bought
                        ? AppColors.primaryLighter.withValues(alpha: 0.4)
                        : AppColors.primaryLighter,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                bought ? 'Bought' : 'Buy',
                textAlign: TextAlign.center,
                style: const TextStyle(
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
