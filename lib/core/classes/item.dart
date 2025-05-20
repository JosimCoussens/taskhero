// ignore_for_file: constant_identifier_names

enum ItemCategory { Weapons, Armour, Shields }

class Item {
  int id;
  String name;
  ItemCategory category;
  String imagePath;
  bool isPurchased;
  int price;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.price,
    this.isPurchased = false,
  });

  void togglePurchased() {
    isPurchased = !isPurchased;
  }

  // Optional: Category to String
  String get categoryName => category.name;
}
