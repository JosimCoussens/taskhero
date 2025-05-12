import 'package:flutter/material.dart';
import 'package:taskhero/classes/icon.dart';

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
}

class AppIcons {
  static List<AppIcon> icons = [
    AppIcon(id: 'home', icon: Icon(Icons.home)),
    AppIcon(id: 'work', icon: Icon(Icons.work)),
    AppIcon(id: 'school', icon: Icon(Icons.school)),
    AppIcon(id: 'shopping', icon: Icon(Icons.shopping_cart)),
    AppIcon(id: 'fitness', icon: Icon(Icons.fitness_center)),
    AppIcon(id: 'travel', icon: Icon(Icons.airplanemode_active)),
    AppIcon(id: 'entertainment', icon: Icon(Icons.movie)),
    AppIcon(id: 'health', icon: Icon(Icons.local_hospital)),
    AppIcon(id: 'finance', icon: Icon(Icons.attach_money)),
  ];
}
