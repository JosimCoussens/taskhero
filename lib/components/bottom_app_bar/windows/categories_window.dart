import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/components/bottom_app_bar/windows/create_category_window.dart';

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
                        _buildCategoryTile(
                          Icons.shopping_bag_outlined,
                          'Grocery',
                          Colors.greenAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.work_outline,
                          'Work',
                          Colors.orangeAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.fitness_center,
                          'Sport',
                          Colors.cyanAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        // ... other tiles with the same pattern
                        _buildCategoryTile(
                          Icons.brush,
                          'Design',
                          Colors.tealAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.school_outlined,
                          'University',
                          Colors.indigoAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.campaign_outlined,
                          'Social',
                          Colors.pinkAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.music_note_outlined,
                          'Music',
                          Colors.purpleAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.health_and_safety_outlined,
                          'Health',
                          Colors.lightGreenAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.movie_outlined,
                          'Movie',
                          Colors.lightBlueAccent,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        _buildCategoryTile(
                          Icons.home_outlined,
                          'Home',
                          Colors.orange.shade200,
                          selectedCategory,
                          (value) => setState(() => selectedCategory = value),
                        ),
                        GestureDetector(
                          onTap: () {
                            showCreateCategory(context);
                          },
                          child: Container(
                            // ... rest of the code remains the same
                          ),
                        ),
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
  IconData icon,
  String label,
  Color color,
  String selectedCategory,
  Function(String) onCategorySelected, // Change this callback signature
) {
  final isSelected = selectedCategory == label;

  return GestureDetector(
    onTap: () {
      // Call the callback with the new value instead of directly using setState
      onCategorySelected(isSelected ? '' : label); // Toggle
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:
              isSelected
                  ? [
                    color.withValues(alpha: 1.0),
                    color.withValues(alpha: 0.85),
                  ]
                  : [
                    color.withValues(alpha: 0.5),
                    color.withValues(alpha: 0.3),
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
          Icon(icon, size: 30, color: Colors.black.withValues(alpha: 0.7)),
          const SizedBox(height: 8),
          Text(
            label,
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
