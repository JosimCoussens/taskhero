// ignore_for_file: constant_identifier_names

enum ItemCategory { Weapon, Armour, Shield }

class Item {
  int id;
  String name;
  ItemCategory category;
  String imagePath;
  int levelRequirement;
  double xpGain;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.levelRequirement,
    required this.xpGain,
  });
}
