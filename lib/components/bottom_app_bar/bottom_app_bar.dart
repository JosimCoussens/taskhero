import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/components/widgets.dart';
import 'package:taskhero/constants.dart';
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
          onPressed: (() => {}),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_month),
          iconSize: mainIconSize,
          onPressed: (() => {}),
        ),
        addTaskIcon(context, mainIconSize),
        IconButton(
          icon: const Icon(Icons.shopping_basket),
          iconSize: mainIconSize,
          onPressed: (() => {}),
        ),
        IconButton(
          icon: const Icon(Icons.inventory),
          iconSize: mainIconSize,
          onPressed: (() => {}),
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
  String selectedRepeat = ''; // Allow deselection
  const iconSize = 32.0;

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
                InputTextField(hintText: 'Title', maxLines: 1),
                const SizedBox(height: 16),
                InputTextField(hintText: 'Description', maxLines: 3),
                const SizedBox(height: 16),
                _showTaskRepeatCycle(selectedRepeat, (val) {
                  setState(() => selectedRepeat = val);
                }),
                const SizedBox(height: 16),
                _showTaskIcons(iconSize, context),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      );
    },
  );
}

Row _showTaskIcons(double iconSize, BuildContext context) {
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
        onPressed: () {
          // Submit task
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Row _showTaskRepeatCycle(
  String selectedRepeat,
  void Function(String) onChanged,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children:
        ['Daily', 'Weekly', 'Monthly'].map((label) {
          final isSelected = selectedRepeat == label;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () {
                  onChanged(isSelected ? '' : label); // toggle
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
