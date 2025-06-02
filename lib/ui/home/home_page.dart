import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/styles.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/home/components/empty_state.dart';
import 'package:taskhero/ui/home/components/section_header.dart';
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
          appBar: const AppHeader(title: "Home"),
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
      return buildEmptyState();
    }

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: backgroundImage('assets/images/castle.png'),
        child: Column(
          spacing: AppParams.generalSpacing,
          children: [
            buildSectionHeader('What do you want to do today?'),
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
}
