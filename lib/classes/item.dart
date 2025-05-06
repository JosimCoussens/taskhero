class Item {
  int id;
  String name;
  String category;
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

  // Method
  void togglePurchased() {
    isPurchased = !isPurchased;
  }
}
