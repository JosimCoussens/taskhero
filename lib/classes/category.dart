import 'package:flutter/material.dart';

class Category {
  String id;
  String name;
  Color color;
  String iconName;

  Category({
    this.id = '',
    required this.name,
    required this.color,
    required this.iconName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.toARGB32(),
      'icon': iconName,
    };
  }

  factory Category.fromFirestore(Map<String, dynamic> data) {
    return Category(
      id: data['id'] as String,
      name: data['name'] ?? '',
      color: Color(data['color'] as int),
      iconName: data['icon'] ?? '',
    );
  }
}
