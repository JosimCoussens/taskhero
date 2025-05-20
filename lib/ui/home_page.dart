import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/levelup_dialog.dart';
import 'package:taskhero/ui/todo/presentation/task_list.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> uncompletedTodos = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppParams.showLevelUpDialog,
      builder: (context, showLevelUpDialog, _) {
        return Scaffold(
          appBar: AppHeader(title: "Home"),
          body:
              isLoading
                  ? _buildLoading()
                  : showLevelUpDialog
                  ? levelUpDialog()
                  : _buildContent(),
          bottomNavigationBar: bottomAppBar(context, () {
            setState(() {
              _loadTodos();
            });
          }),
        );
      },
    );
  }

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future<void> _loadTodos() async {
    final todosTemp = await TodoService.getAllUncompleted();

    setState(() {
      uncompletedTodos = todosTemp;
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget _buildLoading() {
    return const SafeArea(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildContent() {
    if (uncompletedTodos.isEmpty) {
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
        child: Column(
          children: [
            _buildSectionHeader('What do you want to do today?'),
            showTaskList(uncompletedTodos, () {
              setState(() {
                _loadTodos();
              });
            }),
          ],
        ),
      ),
    );
  }

  Future<void> toggleCompletion(Todo todo) async {
    await TodoService.toggleCompletion(todo);
    final updatedTodos = await TodoService.getAllUncompleted();
    setState(() {
      uncompletedTodos = updatedTodos;
    });
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
