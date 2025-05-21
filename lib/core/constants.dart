import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/category.dart';
import 'package:taskhero/core/classes/item.dart';

class AppColors {
  static const Color primaryLighter = Color(0xff64BAFB);
  static const Color primaryLight = Color(0xff1C7BC4);
  static const Color primary = Color(0xff114873);
}

class DatabaseParams {
  static String equippedTableName = 'equippedItems';
}

class AppParams {
  static String? userId;
  static String? loginMethod;
  static String? googleProfileImage;
  static String defaultProfileImage = 'assets/images/avatar.png';

  static const String coinPath = 'assets/images/coin.png';
  static const String xpPath = 'assets/images/xp_coin.png';
  static const String calendarName = 'taskhero';

  static const double generalSpacing = 16.0;
  static ColorFilter backgroundImageColorFilter = ColorFilter.mode(
    Colors.black.withValues(alpha: 0.4),
    BlendMode.darken,
  );
  static List<Category> categories = [
    Category(
      name: 'General',
      color: Colors.blueAccent,
      icon: const Icon(Icons.category_outlined),
    ),
    Category(
      name: 'Grocery',
      color: Colors.greenAccent,
      icon: const Icon(Icons.shopping_bag_outlined),
    ),
    Category(
      name: 'Work',
      color: Colors.orangeAccent,
      icon: const Icon(Icons.work_outline),
    ),
    Category(
      name: 'Sport',
      color: Colors.cyanAccent,
      icon: const Icon(Icons.fitness_center),
    ),
    Category(
      name: 'Hobbies',
      color: Colors.tealAccent,
      icon: const Icon(Icons.brush),
    ),
    Category(
      name: 'School',
      color: Colors.indigoAccent,
      icon: const Icon(Icons.school_outlined),
    ),
    Category(
      name: 'Social',
      color: Colors.pinkAccent,
      icon: const Icon(Icons.campaign_outlined),
    ),
    Category(
      name: 'Music',
      color: Colors.purpleAccent,
      icon: const Icon(Icons.music_note_outlined),
    ),
    Category(
      name: 'Health',
      color: Colors.lightGreenAccent,
      icon: const Icon(Icons.health_and_safety_outlined),
    ),
    Category(
      name: 'Movie',
      color: Colors.lightBlueAccent,
      icon: const Icon(Icons.movie_outlined),
    ),
    Category(
      name: 'Home',
      color: Colors.orange.shade200,
      icon: const Icon(Icons.home_outlined),
    ),
  ];
  static List<Item> allItems = [
    // Weapons
    Item(
      id: 0,
      name: 'Sword',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/weapons/sword.png',
      levelRequirement: 1,
      xpGain: 1.025,
    ),
    Item(
      id: 1,
      name: 'Axe',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/weapons/axe.png',
      levelRequirement: 2,
      xpGain: 1.05,
    ),
    Item(
      id: 2,
      name: 'Bow',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/weapons/bow.png',
      levelRequirement: 3,
      xpGain: 1.1,
    ),
    // Armour
    Item(
      id: 3,
      name: 'Helmet 1',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_1.png',
      levelRequirement: 1,
      xpGain: 1.025,
    ),
    Item(
      id: 4,
      name: 'Helmet 2',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_2.png',
      levelRequirement: 2,
      xpGain: 1.05,
    ),
    Item(
      id: 5,
      name: 'Helmet 3',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_3.png',
      levelRequirement: 3,
      xpGain: 1.1,
    ),
    Item(
      id: 6,
      name: 'Helmet 4',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_4.png',
      levelRequirement: 4,
      xpGain: 1.25,
    ),
    Item(
      id: 7,
      name: 'Helmet 5',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_5.png',
      levelRequirement: 5,
      xpGain: 1.5,
    ),
    // Shields
    Item(
      id: 8,
      name: 'Shield 1',
      category: ItemCategory.Shields,
      imagePath: 'assets/images/shields/shield_1.png',
      levelRequirement: 1,
      xpGain: 1.025,
    ),
    Item(
      id: 9,
      name: 'Shield 2',
      category: ItemCategory.Shields,
      imagePath: 'assets/images/shields/shield_2.png',
      levelRequirement: 2,
      xpGain: 1.05,
    ),
    Item(
      id: 10,
      name: 'Shield 3',
      category: ItemCategory.Shields,
      imagePath: 'assets/images/shields/shield_3.png',
      levelRequirement: 3,
      xpGain: 1.1,
    ),
    Item(
      id: 11,
      name: 'Shield 4',
      category: ItemCategory.Shields,
      imagePath: 'assets/images/shields/shield_4.png',
      levelRequirement: 4,
      xpGain: 1.25,
    ),
  ];

  static ValueNotifier<int> xp = ValueNotifier<int>(0);
  static ValueNotifier<int> level = ValueNotifier<int>(0);
  static ValueNotifier<bool> showLevelUpDialog = ValueNotifier<bool>(false);
}
