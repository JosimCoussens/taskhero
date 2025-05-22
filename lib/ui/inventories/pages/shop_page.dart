import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/item.dart';
import 'package:taskhero/data/shop/item_service.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/ui/inventories/components/item_overview.dart';
import 'package:taskhero/core/constants.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var allItems = AppParams.allItems;
    return Scaffold(
      appBar: AppHeader(title: 'Shop'),
      body: Container(
        padding: const EdgeInsets.only(
          top: AppParams.generalSpacing,
          left: AppParams.generalSpacing,
          right: AppParams.generalSpacing,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/market.png'),
            colorFilter: AppParams.backgroundImageColorFilter,
            fit: BoxFit.cover,
          ),
        ),
        child:
            allItems.isEmpty
                ? null
                : FutureBuilder(
                  future: ItemService.getEquipped(),
                  builder: (context, snapshot) {
                    var equippedItems = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: buildInventory(
                        context,
                        allItems,
                        equippedItems,
                        () {
                          setState(() {});
                        },
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
}
