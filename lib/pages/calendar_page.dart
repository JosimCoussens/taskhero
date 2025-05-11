import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: showContent(),
      bottomNavigationBar: bottomAppBar(context),
    );
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
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.subtract(
                      const Duration(days: 7),
                    );
                  });
                },
              ),
              Text(
                DateFormat.yMMMM().format(selectedDate).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () {
                  setState(() {
                    selectedDate = selectedDate.add(const Duration(days: 7));
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                daysOfWeek.map((day) {
                  final isSelected = DateUtils.isSameDay(day, selectedDate);
                  final isWeekend =
                      day.weekday == DateTime.saturday ||
                      day.weekday == DateTime.sunday;
                  final isToday = DateUtils.isSameDay(day, DateTime.now());

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day;
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

  Widget _buildDayColumn(
    String dayName,
    String dayNumber,
    bool isSelected,
    bool isWeekend,
    bool isToday,
  ) {
    return Column(
      children: [
        Text(
          dayName,
          style: TextStyle(
            color: isWeekend ? Colors.red : Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.white : Colors.transparent,
            border:
                isToday
                    ? Border.all(color: AppColors.primaryLight, width: 1.5)
                    : null,
          ),
          child: Center(
            child: Text(
              dayNumber,
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.blue
                        : (isWeekend ? Colors.red : Colors.white),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Expanded _showTaskList() {
    // You can later filter tasks based on selectedDate here
    return Expanded(
      child: ListView(
        children: [
          _buildTaskItem('Buy Grocery', '16:45', null, null),
          const SizedBox(height: 12),
          _buildTaskItem(
            'Do homework',
            '16:45',
            'University',
            Colors.blue.shade200,
            priority: 1,
          ),
          const SizedBox(height: 12),
          _buildTaskItem(
            'Take out dog',
            '16:45',
            'Home',
            Colors.red.shade200,
            priority: 1,
          ),
        ],
      ),
    );
  }

  Row _showActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => setState(() => selectedDate = DateTime.now()),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: const Text(
              'Tasks',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Show completed logic
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: const Text(
              'Completed',
              style: TextStyle(color: Colors.black87, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(
    String title,
    String time,
    String? category,
    Color? categoryColor, {
    int priority = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Today At $time',
                  style: TextStyle(
                    color: Colors.white.withAlpha(150),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (category != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          if (priority > 0)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  const Icon(Icons.flag, color: Colors.white, size: 16),
                  const SizedBox(width: 2),
                  Text(
                    '$priority',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Main app for testing
void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: CalendarPage()),
  );
}
