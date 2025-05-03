import 'package:flutter/material.dart';
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
  const iconSize = 32.0;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: const Color(0xFFEFF6FF),
    builder: (BuildContext context) {
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
            const TextField(
              decoration: InputDecoration(
                hintText: 'Task title',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Description',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.access_time),
                  iconSize: iconSize,
                  color: Colors.black87,
                  onPressed: () {
                    showCalendar(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.category),
                  iconSize: iconSize,
                  color: Colors.black87,
                  onPressed: () {
                    showCategories(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.flag),
                  iconSize: iconSize,
                  color: Colors.black87,
                  onPressed: () {
                    showPriority(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.star_border),
                  iconSize: iconSize,
                  color: Colors.black87,
                  onPressed: () {
                    showDifficulty(context);
                  },
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
            ),
            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
}
