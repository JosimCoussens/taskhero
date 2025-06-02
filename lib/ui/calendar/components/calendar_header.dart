import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';
import 'package:taskhero/ui/app_bar/day_bubble.dart';

class CalendarHeader extends StatefulWidget {
  final DateTime initialDate;
  final Function(
    DateTime selectedDate,
    List<Todo> uncompleted,
    List<Todo> completed,
  )
  onDateSelected;

  const CalendarHeader({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  void _changeWeek(int offset) {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: offset));
    });
  }

  List<DateTime> get _daysOfWeek {
    final startOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );
    return List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: StylingParams.borderRadius,
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
              _navArrow(Icons.chevron_left, () => _changeWeek(-7)),
              Text(
                DateFormat.yMMMM().format(selectedDate).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              _navArrow(Icons.chevron_right, () => _changeWeek(7)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                _daysOfWeek.map((day) {
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
                      });

                      widget.onDateSelected(day, uncompleted, completed);
                    },
                    child: DayBubble(
                      day: day,
                      dayName: DateFormat.E().format(day).toUpperCase(),
                      dayNumber: day.day.toString(),
                      isSelected: isSelected,
                      isWeekend: isWeekend,
                      isToday: isToday,
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
}
