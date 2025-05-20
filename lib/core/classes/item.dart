// ignore_for_file: constant_identifier_names

enum ItemCategory { Weapons, Armour, Shields }

class Item {
  int? id;
  String name;
  ItemCategory category;
  String imagePath;
  int levelRequirement;

  Item({
    this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.levelRequirement,
  });

  // Optional: Category to String
  String get categoryName => category.name;
}
