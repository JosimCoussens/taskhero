class Item {
  int id;
  String name;
  String category;
  String imagePath;
  bool isPurchased;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    this.isPurchased = false,
  });

  // Method
  void togglePurchased() {
    isPurchased = !isPurchased;
  }
}
