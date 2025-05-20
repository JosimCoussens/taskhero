import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/category.dart';
import 'package:taskhero/ui/widgets.dart';
import 'package:taskhero/core/constants.dart';

Future<dynamic> showCategories(BuildContext context) {
  String selectedCategory = '';

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WindowHeader(title: "Choose Category"),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        ...AppParams.categories.map((category) {
                          return _buildCategoryTile(
                            category,
                            selectedCategory,
                            (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            },
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Components().buttons(
                      context,
                      () => Navigator.pop(context),
                      () => Navigator.pop(
                        context,
                        selectedCategory,
                      ), // Return the selected category
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Update the callback type to be clearer
Widget _buildCategoryTile(
  Category category,
  String selectedCategory,
  Function(String) onCategorySelected, // Change this callback signature
) {
  final isSelected = selectedCategory == category.name;

  return GestureDetector(
    onTap: () {
      // Call the callback with the new value instead of directly using setState
      onCategorySelected(isSelected ? '' : category.name); // Toggle
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isSelected
                  ? [
                    category.color.withValues(alpha: 1.0),
                    category.color.withValues(alpha: 0.85),
                  ]
                  : [
                    category.color.withValues(alpha: 0.5),
                    category.color.withValues(alpha: 0.3),
                  ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          category.icon,
          const SizedBox(height: 8),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    ),
  );
}
