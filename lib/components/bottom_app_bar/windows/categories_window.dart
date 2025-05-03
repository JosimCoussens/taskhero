import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';

Future<dynamic> showCategories(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (BuildContext context) {
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
                    ),
                    _buildCategoryTile(
                      Icons.work_outline,
                      'Work',
                      Colors.orangeAccent,
                    ),
                    _buildCategoryTile(
                      Icons.fitness_center,
                      'Sport',
                      Colors.cyanAccent,
                    ),
                    _buildCategoryTile(
                      Icons.brush,
                      'Design',
                      Colors.tealAccent,
                    ),
                    _buildCategoryTile(
                      Icons.school_outlined,
                      'University',
                      Colors.indigoAccent,
                    ),
                    _buildCategoryTile(
                      Icons.campaign_outlined,
                      'Social',
                      Colors.pinkAccent,
                    ),
                    _buildCategoryTile(
                      Icons.music_note_outlined,
                      'Music',
                      Colors.purpleAccent,
                    ),
                    _buildCategoryTile(
                      Icons.health_and_safety_outlined,
                      'Health',
                      Colors.lightGreenAccent,
                    ),
                    _buildCategoryTile(
                      Icons.movie_outlined,
                      'Movie',
                      Colors.lightBlueAccent,
                    ),
                    _buildCategoryTile(
                      Icons.home_outlined,
                      'Home',
                      Colors.orange.shade200,
                    ),
                    _buildCategoryTile(
                      Icons.add,
                      'Create New',
                      Colors.green.shade200,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Components().buttons(
                  context,
                  () => Navigator.pop(context),
                  () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

_buildCategoryTile(IconData icon, String label, Color color) {
  return GestureDetector(
    onTap: () {
      // Handle category selection logic here
    },
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.9),
            color.withValues(alpha: 0.7),
          ], // Subtle gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(
          12,
        ), // Slightly rounded corners for modern look
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
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centering content properly
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.black.withValues(
              alpha: 0.7,
            ), // Lightened icon for better contrast
          ),
          const SizedBox(
            height: 8,
          ), // Slightly larger space for improved spacing
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16, // Slightly smaller for better balance
              fontWeight: FontWeight.w600, // Slightly heavier font weight
              letterSpacing: 0.5, // Added letter spacing for readability
              color: Colors.black.withValues(
                alpha: 0.7,
              ), // Improved contrast with white text
            ),
          ),
        ],
      ),
    ),
  );
}
