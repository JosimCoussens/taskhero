import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';

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
                  spacing: 16,
                  children: [
                    InputTextField(
                      hintText: 'Category Name',
                      maxLines: 1,
                      controller: categoryNameController,
                    ),
                    _showChooseIconButton(),
                    _showColorOverview(categoryColors),
                    Components().buttons(
                      context,
                      () => Navigator.pop(context),
                      () => Navigator.pop(context),
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

Row _showColorOverview(List<Color> categoryColors) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        categoryColors.map((color) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          );
        }).toList(),
  );
}

ElevatedButton _showChooseIconButton() {
  return ElevatedButton(
    onPressed: () {},
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
