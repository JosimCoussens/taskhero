import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/calendar/components/calendar_header.dart';
import 'package:taskhero/ui/levelup_dialog.dart';
import 'package:taskhero/ui/todo/presentation/task_list.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';

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
    return ValueListenableBuilder(
      valueListenable: AppParams.showLevelUpDialog,
      builder: (context, showLevelUpDialog, _) {
        return Scaffold(
          appBar: const AppHeader(title: "Calendar"),
          body: showLevelUpDialog ? levelUpDialog() : showContent(),
          bottomNavigationBar: bottomAppBar(context, () {
            setState(() {
              _fetchTasks();
            });
          }),
        );
      },
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
          spacing: AppParams.generalSpacing,
          children: [
            CalendarHeader(
              initialDate: selectedDate,
              onDateSelected: (selectedDate, uncompleted, completed) {
                setState(() {
                  this.selectedDate = selectedDate;
                  uncompletedTodos = uncompleted;
                  completedTodos = completed;
                });
              },
            ),
            _showActionButtons(),
            showTaskList(
              _selectedButtonIndex == 0 ? uncompletedTodos : completedTodos,
              () {
                setState(() {
                  _fetchTasks();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  int _selectedButtonIndex = 0;

  Row _showActionButtons() {
    return Row(
      spacing: AppParams.generalSpacing / 2,
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
}
