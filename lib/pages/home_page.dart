import 'package:flutter/material.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/bottom_app_bar/components/flutter_todo_widget.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/todoService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> todaysTodos = [];
  List<Todo> todayCompletedTodos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final today = await TodoService().getTodays();
    final completed = await TodoService().getTodayCompleted();

    setState(() {
      todaysTodos = today;
      todayCompletedTodos = completed;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: isLoading ? _buildLoading() : _buildContent(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  Widget _buildLoading() {
    return const SafeArea(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildContent() {
    if (todaysTodos.isEmpty && todayCompletedTodos.isEmpty) {
      return _buildEmptyState();
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/castle.png'),
            fit: BoxFit.cover,
            colorFilter: AppParams.backgroundImageColorFilter,
          ),
        ),
        child: ListView(
          children: [
            if (todaysTodos.isNotEmpty)
              ..._buildTodoSection('Today', todaysTodos),
            if (todayCompletedTodos.isNotEmpty)
              ..._buildTodoSection('Completed', todayCompletedTodos),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTodoSection(String title, List<Todo> todos) {
    final widgets = <Widget>[];
    for (int i = 0; i < todos.length; i++) {
      widgets.add(TodoWidget(todos[i]));
      if (i < todos.length - 1) {
        widgets.add(const SizedBox(height: 10)); // Add gap between widgets
      }
    }

    return [
      _buildSectionHeader(title),
      const SizedBox(height: 8),
      ...widgets,
      const SizedBox(height: 16),
    ];
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/knight.png', height: 300),
            const SizedBox(height: 20),
            const Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap + to add your tasks',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
