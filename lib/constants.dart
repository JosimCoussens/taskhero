import 'package:flutter/material.dart';

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
