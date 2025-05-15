import 'package:flutter/material.dart';
import 'package:taskhero/classes/category.dart';
import 'package:taskhero/classes/item.dart';

class AppColors {
  static const Color primaryLighter = Color(0xff64BAFB);
  static const Color primaryLight = Color(0xff1C7BC4);
  static const Color primary = Color(0xff114873);
}

class AppParams {
  static const String avatarPath = 'assets/images/avatar.png';
  static const double generalSpacing = 16.0;
  static int xp = -1;
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
    Item(
      id: 5,
      name: 'Silver Sword',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/sword.png',
      isPurchased: true,
      price: 25,
    ),
    Item(
      id: 1,
      name: 'Axe',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/axe.png',
      isPurchased: true,
      price: 20,
    ),
    Item(
      id: 1,
      name: 'Bow',
      category: ItemCategory.Weapons,
      imagePath: 'assets/images/bow.png',
      isPurchased: true,
      price: 20,
    ),
    Item(
      id: 2,
      name: 'Helmet 1',
      category: ItemCategory.Armour,
      imagePath: 'assets/images/helmets/helmet_1.png',
      isPurchased: true,
      price: 15,
    ),
    Item(
      id: 4,
      name: 'Shield 1',
      category: ItemCategory.Shields,
      imagePath: 'assets/images/shields/shield_1.png',
      isPurchased: true,
      price: 15,
    ),
  ];
}
