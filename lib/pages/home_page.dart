import 'package:flutter/material.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/components/flutter_todo_widget.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/services/item_service.dart';
import 'package:taskhero/services/todo_service.dart';
import 'package:taskhero/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> uncompletedTodos = [];
  bool isLoading = true;

  @override
  void initState() {
    _loadTodos();
    _setXp();
    _setItems();
    super.initState();
  }

  Future<void> _setXp() async {
    AppParams.xp = await UserService.getXp();
  }

  Future<void> _setItems() async {
    var boughtItems = await ItemService.getBoughtItems();
    for (var item in AppParams.allItems) {
      item.isPurchased = boughtItems.any((bought) => bought.id == item.id);
    }
    isLoading = false;
  }

  Future<void> _loadTodos() async {
    final todosTemp = await TodoService.getAllUncompleted();

    setState(() {
      uncompletedTodos = todosTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Home"),
      body: isLoading ? _buildLoading() : _buildContent(),
      bottomNavigationBar: bottomAppBar(context, () {
        setState(() {
          _loadTodos();
        });
      }),
    );
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
        child: ListView(
          children: [
            if (uncompletedTodos.isNotEmpty)
              ..._buildTodoSection('Today', uncompletedTodos),
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

  List<Widget> _buildTodoSection(String title, List<Todo> todos) {
    final widgets = <Widget>[];
    for (int i = 0; i < todos.length; i++) {
      widgets.add(
        TodoWidget(todos[i], () async {
          await toggleCompletion(todos[i]);
          setState(() {});
        }),
      );
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
