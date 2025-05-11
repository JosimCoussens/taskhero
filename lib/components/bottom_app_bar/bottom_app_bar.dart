import 'package:flutter/material.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/pages/calendar_page.dart';
import 'package:taskhero/pages/home_page.dart';
import 'package:taskhero/pages/inventory_page.dart';
import 'package:taskhero/pages/shop_page.dart';
import 'package:taskhero/services/todoService.dart';
import 'windows/categories_window.dart';
import 'windows/difficulty_window.dart';
import 'windows/priority_window.dart';
import 'windows/calendar_window.dart';

BottomAppBar bottomAppBar(BuildContext context) {
  const mainIconSize = 30.0;
  return BottomAppBar(
    height: 100,
    color: const Color.fromARGB(255, 232, 244, 255),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.home),
          iconSize: mainIconSize,
          onPressed:
              (() => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                ),
              }),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_month),
          iconSize: mainIconSize,
          onPressed:
              (() => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalendarPage()),
                ),
              }),
        ),
        addTaskIcon(context, mainIconSize),
        IconButton(
          icon: const Icon(Icons.shopping_basket),
          iconSize: mainIconSize,
          onPressed:
              (() => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ShopPage()),
                ),
              }),
        ),
        IconButton(
          icon: const Icon(Icons.inventory),
          iconSize: mainIconSize,
          onPressed:
              (() => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryPage(),
                  ),
                ),
              }),
        ),
      ],
    ),
  );
}

GestureDetector addTaskIcon(BuildContext context, double mainIconSize) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryLight,
      ),
      child: Icon(Icons.add, color: Colors.white, size: mainIconSize),
    ),
    onTap: () => addTask(context),
  );
}

Future<dynamic> addTask(BuildContext context) {
  int selectedRepeat = 0; // Allow deselection
  const iconSize = 32.0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Task',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                InputTextField(
                  hintText: 'Title',
                  maxLines: 1,
                  controller: titleController,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  hintText: 'Description',
                  maxLines: 3,
                  controller: descriptionController,
                ),
                const SizedBox(height: 16),
                _showTaskRepeatCycle(selectedRepeat, (val) {
                  setState(() => selectedRepeat = val);
                }),
                const SizedBox(height: 16),
                _showTaskIcons(
                  iconSize,
                  context,
                  titleController,
                  descriptionController,
                  selectedRepeat,
                  setState,
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      );
    },
  );
}

Row _showTaskIcons(
  double iconSize,
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  int repeatCycle,
  StateSetter setState,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        icon: const Icon(Icons.access_time),
        iconSize: iconSize,
        color: Colors.black87,
        onPressed: () => showCalendar(context),
      ),
      IconButton(
        icon: const Icon(Icons.category),
        iconSize: iconSize,
        color: Colors.black87,
        onPressed: () => showCategories(context),
      ),
      IconButton(
        icon: const Icon(Icons.flag),
        iconSize: iconSize,
        color: Colors.black87,
        onPressed: () => showPriority(context),
      ),
      IconButton(
        icon: const Icon(Icons.star_border),
        iconSize: iconSize,
        color: Colors.black87,
        onPressed: () => showDifficulty(context),
      ),
      IconButton(
        icon: const Icon(Icons.send),
        iconSize: iconSize,
        color: Colors.blue,
        onPressed: () async {
          final title = titleController.text.trim();
          final description = descriptionController.text.trim();

          if (title.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a title')),
            );
            return;
          }

          final newTask = Todo(
            title: title,
            description: description,
            repeatCycle: repeatCycle,
          );

          await TodoService().addTask(newTask);

          Navigator.of(context).pop(); // Close bottom sheet
        },
      ),
    ],
  );
}

Row _showTaskRepeatCycle(int selectedRepeat, void Function(int) onChanged) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        ['Daily', 'Weekly', 'Monthly'].map((label) {
          final isSelected =
              selectedRepeat ==
              ['Daily', 'Weekly', 'Monthly'].indexOf(label) + 1;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  switch (label) {
                    case 'Daily':
                      selectedRepeat = 1;
                      onChanged(selectedRepeat);
                      break;
                    case 'Weekly':
                      selectedRepeat = 2;
                      onChanged(selectedRepeat);
                      break;
                    case 'Monthly':
                      selectedRepeat = 3;
                      onChanged(selectedRepeat);
                      break;
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
  );
}
