import 'package:flutter/material.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  int selectedIndex = 0;
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
          image: AssetImage('assets/images/waterfall.png'),
          colorFilter: AppParams.backgroundImageColorFilter,
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppParams.generalSpacing),
        child: Column(
          spacing: 16,
          children: [
            _showCalendarHeader(),
            _showActionButtons(),
            _showTaskList(),
          ],
        ),
      ),
    );
  }

  Container _showCalendarHeader() {
    return Container(
      color: AppColors.primary, // Deep blue
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.chevron_left, color: Colors.white),
              Text(
                'FEBRUARY',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDayColumn('MON', '7', false, false),
              _buildDayColumn('TUE', '8', false, false),
              _buildDayColumn('WED', '9', true, false), // Selected
              _buildDayColumn('THU', '10', false, false),
              _buildDayColumn('FRI', '11', false, false),
              _buildDayColumn('SAT', '12', false, true), // Weekend
              _buildDayColumn('SUN', '13', false, true), // Weekend
            ],
          ),
        ],
      ),
    );
  }

  Expanded _showTaskList() {
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
            onPressed: () {
              setState(() {
                selectedIndex = 0;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  selectedIndex == 0 ? AppColors.primaryLight : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: Text(
              'Today',
              style: TextStyle(
                color: selectedIndex == 0 ? Colors.white : Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedIndex = 1;
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  selectedIndex == 1 ? AppColors.primaryLight : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child: Text(
              'Completed',
              style: TextStyle(
                color: selectedIndex == 1 ? Colors.white : Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayColumn(
    String dayName,
    String dayNumber,
    bool isSelected,
    bool isWeekend,
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
                    color: Colors.white.withValues(alpha: 0.7),
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
