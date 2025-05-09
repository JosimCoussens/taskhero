import 'package:flutter/material.dart';
import 'package:taskhero/classes/todo.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';
import 'package:taskhero/services/todoService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Todo> todos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    List<Todo> loadedTodos = await TodoService().getAll();
    setState(() {
      todos = loadedTodos;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: isLoading ? _loadingContent() : content(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  Widget _loadingContent() {
    return const SafeArea(child: Center(child: CircularProgressIndicator()));
  }

  SafeArea content() {
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

AppBar header() {
  return AppBar(
    automaticallyImplyLeading: false, // Do not show back arrow
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 64,
    title: Stack(
      alignment: Alignment.center,
      children: [
        // Centered Title
        const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Left & Right Widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.filter_list, color: Colors.black),
            Row(
              children: [
                const Text(
                  '112',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset('assets/images/xp_coin.png', height: 20, width: 20),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
