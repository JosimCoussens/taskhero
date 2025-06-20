import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/core/styles.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/ui/inventories/components/inventory/equipped_overview.dart';
import 'package:taskhero/ui/inventories/components/item_overview.dart';
import 'package:taskhero/ui/inventories/pages/shop_page.dart';
import 'package:taskhero/data/shop/item_service.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var unlockedItems = ItemService.getUnlockedItems();
    return Scaffold(
      appBar: const AppHeader(title: 'Inventory'),
      body: Container(
        padding: const EdgeInsets.only(
          top: AppParams.generalSpacing,
          left: AppParams.generalSpacing,
          right: AppParams.generalSpacing,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: backgroundImage('assets/images/armoury.png'),
        child:
            unlockedItems.isEmpty
                ? _buildEmptyInventoryMessage()
                : FutureBuilder(
                  future: ItemService.getEquipped(),
                  builder: (context, snapshot) {
                    var equippedItems = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          equippedGear(equippedItems),
                          buildInventory(
                            context,
                            unlockedItems,
                            equippedItems,
                            () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
      bottomNavigationBar: bottomAppBar(context, () {
        setState(() {});
      }),
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
}
