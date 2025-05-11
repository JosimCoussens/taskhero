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

const double mainIconSize = 30.0;
const double iconSize = 32.0;

BottomAppBar bottomAppBar(BuildContext context) {
  return BottomAppBar(
    height: 100,
    color: const Color.fromARGB(255, 232, 244, 255),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _navIcon(context, Icons.home, const HomePage()),
        _navIcon(context, Icons.calendar_month, const CalendarPage()),
        addTaskIcon(context),
        _navIcon(context, Icons.shopping_basket, const ShopPage()),
        _navIcon(context, Icons.inventory, const InventoryPage()),
      ],
    ),
  );
}

IconButton _navIcon(BuildContext context, IconData icon, Widget page) {
  return IconButton(
    icon: Icon(icon),
    iconSize: mainIconSize,
    onPressed:
        () => Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
  );
}

GestureDetector addTaskIcon(BuildContext context) {
  return GestureDetector(
    onTap: () => addTask(context),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryLight,
      ),
      child: const Icon(Icons.add, color: Colors.white, size: mainIconSize),
    ),
  );
}

Future<void> addTask(BuildContext context) {
  int selectedRepeat = 0;
  int? selectedPriority;
  int? selectedDifficulty;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
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
                _repeatCycleSelector(
                  selectedRepeat,
                  (val) => setState(() => selectedRepeat = val),
                ),
                const SizedBox(height: 16),
                _taskActionIcons(
                  context,
                  titleController,
                  descriptionController,
                  selectedRepeat,
                  selectedPriority,
                  selectedDifficulty,
                  (val) => setState(() => selectedPriority = val),
                  (val) => setState(() => selectedDifficulty = val),
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

Row _taskActionIcons(
  BuildContext context,
  TextEditingController titleController,
  TextEditingController descriptionController,
  int repeatCycle,
  int? selectedPriority,
  int? selectedDifficulty,
  ValueChanged<int> onPriorityChanged,
  ValueChanged<int> onDifficultyChanged,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
        icon: const Icon(Icons.access_time),
        iconSize: iconSize,
        onPressed: () => showCalendar(context),
      ),
      IconButton(
        icon: const Icon(Icons.category),
        iconSize: iconSize,
        onPressed: () => showCategories(context),
      ),
      IconButton(
        icon: const Icon(Icons.flag),
        iconSize: iconSize,
        onPressed: () async {
          final result = await showPriority(context);
          if (result != null) onPriorityChanged(result);
        },
      ),
      IconButton(
        icon: const Icon(Icons.star_border),
        iconSize: iconSize,
        onPressed: () async {
          final result = await showDifficulty(context);
          if (result != null) onDifficultyChanged(result);
        },
      ),
      IconButton(
        icon: const Icon(Icons.send),
        iconSize: iconSize,
        color: Colors.blue,
        onPressed: () async {
          final title = titleController.text.trim();
          if (title.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a title')),
            );
            return;
          }

          final newTask = Todo(
            title: title,
            description: descriptionController.text.trim(),
            repeatCycle: repeatCycle,
            difficulty: selectedDifficulty ?? 0,
            priority: selectedPriority ?? 0,
            isCompleted: false,
          );

          await TodoService().addTask(newTask);
          if (context.mounted) Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Row _repeatCycleSelector(int selectedRepeat, ValueChanged<int> onChanged) {
  final options = ['Daily', 'Weekly', 'Monthly'];

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        options.map((label) {
          final index = options.indexOf(label) + 1;
          final isSelected = selectedRepeat == index;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => onChanged(index),
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
