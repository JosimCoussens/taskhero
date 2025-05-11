import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/todoService.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();
  List<Todo> completedTodos = [];
  List<Todo> uncompletedTodos = [];

  @override
  Widget build(BuildContext context) {
    _fetchTasks();
    return Scaffold(
      appBar: header(),
      body: showContent(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  void _fetchTasks() async {
    final completed = await TodoService.getCompletedTasks(selectedDate);
    final uncompleted = await TodoService.getUncompletedTasks(selectedDate);
    setState(() {
      completedTodos = completed;
      uncompletedTodos = uncompleted;
    });
  }

  Container showContent() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/waterfall.png'),
          colorFilter: AppParams.backgroundImageColorFilter,
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppParams.generalSpacing),
        child: Column(
          children: [
            _buildCalendarHeader(),
            const SizedBox(height: 16),
            _showActionButtons(),
            const SizedBox(height: 12),
            _showTaskList(),
          ],
        ),
      ),
    );
  }

  Container _buildCalendarHeader() {
    final startOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );
    final daysOfWeek = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navArrow(Icons.chevron_left, () {
                setState(() {
                  selectedDate = selectedDate.subtract(const Duration(days: 7));
                });
              }),
              Text(
                DateFormat.yMMMM().format(selectedDate).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              _navArrow(Icons.chevron_right, () {
                setState(() {
                  selectedDate = selectedDate.add(const Duration(days: 7));
                });
              }),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                daysOfWeek.map((day) {
                  final isSelected = DateUtils.isSameDay(day, selectedDate);
                  final isWeekend =
                      day.weekday == DateTime.saturday ||
                      day.weekday == DateTime.sunday;
                  final isToday = DateUtils.isSameDay(day, DateTime.now());

                  return GestureDetector(
                    onTap: () async {
                      final uncompleted = await TodoService.getUncompletedTasks(
                        day,
                      );
                      final completed = await TodoService.getCompletedTasks(
                        day,
                      );
                      setState(() {
                        selectedDate = day;
                        uncompletedTodos = uncompleted;
                        completedTodos = completed;
                      });
                    },
                    child: _buildDayColumn(
                      DateFormat.E().format(day).toUpperCase(),
                      day.day.toString(),
                      isSelected,
                      isWeekend,
                      isToday,
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _navArrow(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white24,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildDayColumn(
    String dayName,
    String dayNumber,
    bool isSelected,
    bool isWeekend,
    bool isToday,
  ) {
    final Color textColor =
        isSelected
            ? Colors.blue
            : isWeekend
            ? Colors.red
            : Colors.white;

    return Column(
      children: [
        Text(
          dayName,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.white : Colors.transparent,
            border:
                isToday
                    ? Border.all(color: AppColors.primaryLight, width: 2)
                    : null,
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            child: Text(
              dayNumber,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  int _selectedButtonIndex = 0;

  Row _showActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.circle_outlined,
              color: _selectedButtonIndex == 0 ? Colors.white : Colors.white70,
            ),
            label: Text(
              'Uncompleted',
              style: TextStyle(
                fontSize: 16,
                color:
                    _selectedButtonIndex == 0 ? Colors.white : Colors.white70,
              ),
            ),
            onPressed: () {
              if (_selectedButtonIndex != 0) {
                setState(() => _selectedButtonIndex = 0);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedButtonIndex == 0
                      ? AppColors.primaryLight
                      : AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.check_circle_outline,
              color: _selectedButtonIndex == 1 ? Colors.white : Colors.white70,
            ),
            label: Text(
              'Completed',
              style: TextStyle(
                fontSize: 16,
                color:
                    _selectedButtonIndex == 1 ? Colors.white : Colors.white70,
              ),
            ),
            onPressed: () {
              if (_selectedButtonIndex != 1) {
                setState(() => _selectedButtonIndex = 1);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  _selectedButtonIndex == 1
                      ? AppColors.primaryLight
                      : AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
            ),
          ),
        ),
      ],
    );
  }

  Expanded _showTaskList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount:
            _selectedButtonIndex == 0
                ? uncompletedTodos.length
                : completedTodos.length,
        itemBuilder: (context, index) {
          final todo =
              _selectedButtonIndex == 0
                  ? uncompletedTodos[index]
                  : completedTodos[index];
          return Column(
            children: [
              _buildTaskItem(
                todo.title,
                DateFormat.jm().format(todo.date),
                todo.category,
                Colors.green,
              ),
              if (index !=
                  (_selectedButtonIndex == 0
                      ? uncompletedTodos.length - 1
                      : completedTodos.length - 1))
                const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTaskItem(
    String title,
    String time,
    String? category,
    Color? categoryColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (category != null)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                category,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
