import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/data/data_service.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key, required this.allCompleted});

  final List<Todo> allCompleted;

  @override
  Widget build(BuildContext context) {
    var maxValue = _getBarGroups(
      allCompleted,
    ).map((e) => e.barRods[0].toY).reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barTouchData: _barTouchData,
          titlesData: _titlesData,
          borderData: FlBorderData(show: false),
          barGroups: _getBarGroups(allCompleted),
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue + 1,
        ),
      ),
    );
  }

  static List<BarChartGroupData> _getBarGroups(List<Todo> allCompleted) {
    return List.generate(7, (dayIndex) {
      final value =
          (DataService.getDayStats(allCompleted, dayIndex)).toDouble();
      return BarChartGroupData(
        x: dayIndex,
        barRods: [BarChartRodData(toY: value, color: Colors.green, width: 24)],
        showingTooltipIndicators: [0],
      );
    });
  }

  static BarTouchData get _barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (_) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem:
          (group, groupIndex, rod, rodIndex) => BarTooltipItem(
            rod.toY.round().toString(),
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
    ),
  );

  static Widget _getTitles(double value, TitleMeta meta) {
    const labels = ['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Sn'];
    final index = value.toInt();
    final text = (index >= 0 && index < labels.length) ? labels[index] : '';
    return SideTitleWidget(
      meta: meta,
      space: 4,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  static FlTitlesData get _titlesData => const FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: _getTitles,
      ),
    ),
    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );
}
