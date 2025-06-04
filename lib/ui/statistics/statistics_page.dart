import 'package:flutter/material.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/core/styles.dart';
import 'package:taskhero/data/todo_service.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/ui/statistics/widgets/bar_chart.dart';
import 'package:taskhero/ui/statistics/components/insights.dart';
import 'package:taskhero/ui/statistics/components/stats_cards.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const AppHeader(title: 'Statistics'),
      body: _content(),
      bottomNavigationBar: bottomAppBar(context, () {}),
    );
  }

  Widget _content() {
    return Container(
      decoration: backgroundImage('assets/images/armoury.png'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: TodoService.getAllCompleted(),
                builder:
                    (context, snapshot) =>
                        snapshot.data == null || snapshot.data!.isEmpty
                            ? _showNoCompletedScreen()
                            : _showContent(snapshot),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _showContent(AsyncSnapshot<List<Todo>> snapshot) {
    return Column(
      spacing: AppParams.generalSpacing,
      children: [
        _welcomeSection(),
        statsCards(snapshot.data ?? []),
        _chart(),
        insights(snapshot.data ?? []),
      ],
    );
  }

  Center _showNoCompletedScreen() {
    return Center(
      child: Text(
        'No completed tasks yet!',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
      ),
    );
  }

  Container _chart() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: StylingParams.borderRadius,
        border: Border.all(
          color: AppColors.primaryLight,
          width: StylingParams.borderThickness,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          BarChartWidget(),
        ],
      ),
    );
  }

  Container _welcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: StylingParams.borderRadius,
        border: Border.all(
          color: AppColors.primaryLight,
          width: StylingParams.borderThickness,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your productivity and achievements',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
