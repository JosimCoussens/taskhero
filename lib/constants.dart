import 'package:flutter/material.dart';
import 'package:taskhero/classes/category.dart';

class AppColors {
  static const Color primaryLighter = Color(0xff64BAFB);
  static const Color primaryLight = Color(0xff1C7BC4);
  static const Color primary = Color(0xff114873);
}

class AppParams {
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
      name: 'Design',
      color: Colors.tealAccent,
      icon: const Icon(Icons.brush),
    ),
    Category(
      name: 'University',
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
}
