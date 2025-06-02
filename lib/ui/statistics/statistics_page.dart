import 'package:flutter/material.dart';
import 'package:taskhero/ui/app_bar/presentation/bottom_app_bar.dart';
import 'package:taskhero/ui/header/header.dart';
import 'package:taskhero/ui/statistics/bar_chart.dart';

// Template from https://github.com/imaNNeo/fl_chart/blob/main/example/lib/presentation/samples/bar/bar_chart_sample3.dart

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Statistics'),
      body: _content(),
      bottomNavigationBar: bottomAppBar(context, () {}),
    );
  }

  Widget _content() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const BarChartWidget(),
    );
  }
}
