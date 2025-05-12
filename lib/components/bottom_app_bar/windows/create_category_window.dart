// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:taskhero/classes/category.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/category_service.dart';

Future<dynamic> showCreateCategory(BuildContext context) {
  TextEditingController categoryNameController = TextEditingController();
  final List<Color> categoryColors = [
    Color(0xFFD9D750), // Yellow
    Color(0xFF7ED957), // Green
    Color(0xFF50D9C1), // Teal
    Color(0xFF5084D9), // Blue
    Color(0xFF50AED9), // Light Blue
    Color(0xFFD98150), // Orange
    Color(0xFFB150D9), // Purple
    Color(0xFFD9507E), // Pink
  ];
  Color selectedColor = categoryColors[0]; // Default selected color

  return showModalBottomSheet(
    context: context,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WindowHeader(title: "Create New Category"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextField(
                      hintText: 'Category Name',
                      maxLines: 1,
                      controller: categoryNameController,
                    ),
                    _showChooseIconButton(context),
                    _showColorOverview(categoryColors, (color) {
                      selectedColor = color;
                    }),
                    Components().buttons(
                      context,
                      () => Navigator.pop(context),
                      () async {
                        String categoryName =
                            categoryNameController.text.trim();
                        if (categoryName.isNotEmpty) {
                          Category newCategory = Category(
                            name: categoryName,
                            color: selectedColor,
                            iconName: AppIcons.icons[0].id,
                          );
                          await CategoryService.addCategory(newCategory);
                          Navigator.pop(context);
                        } else {
                          // Show an error message if the category name is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Category name cannot be empty'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Row _showColorOverview(
  List<Color> categoryColors,
  Function(Color) onColorSelected,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        categoryColors.map((color) {
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          );
        }).toList(),
  );
}

ElevatedButton _showChooseIconButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      String? selectedIcon = await showModalBottomSheet<String>(
        context: context,
        builder: (BuildContext context) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: AppIcons.icons.length,
            itemBuilder: (BuildContext context, int index) {
              final icon = AppIcons.icons[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, icon.id);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon.icon,
                    const SizedBox(height: 8),
                    Text(
                      icon.id,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      );

      if (selectedIcon != null) {
        // Handle the selected icon (e.g., update the state or UI)
        print('Selected Icon: $selectedIcon');
      }
    },
    style: ButtonStyle(
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      backgroundColor: WidgetStateProperty.all(AppColors.primaryLight),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),
    child: const Text(
      'Choose Icon',
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  );
}
