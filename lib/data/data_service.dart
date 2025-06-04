import 'package:taskhero/core/classes/todo.dart';

class DataService {
  static int getStreak(List<Todo> allCompleted) {
    if (allCompleted.isEmpty) return 0;

    // Sort by completion date, newest last
    allCompleted.sort((a, b) => a.completionDate!.compareTo(b.completionDate!));

    // Extract all unique completion dates (without time)
    final completedDates =
        allCompleted
            .map(
              (todo) => DateTime(
                todo.completionDate!.year,
                todo.completionDate!.month,
                todo.completionDate!.day,
              ),
            )
            .toSet();

    int streak = 0;
    DateTime day = DateTime.now();

    while (completedDates.contains(DateTime(day.year, day.month, day.day))) {
      streak++;
      day = day.subtract(const Duration(days: 1));
    }

    return streak;
  }

  static String getMostProductiveDay(List<Todo> completedTodos) {
    Map<String, int> dayCounts = {};
    for (var todo in completedTodos) {
      var day = todo.completionDate!.weekday.toString();
      dayCounts[day] = (dayCounts[day] ?? 0) + 1;
    }

    String mostProductiveDay =
        dayCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return _dayOfWeek(mostProductiveDay);
  }

  static String _dayOfWeek(String mostProductiveDay) {
    switch (mostProductiveDay) {
      case '1':
        return 'Monday';
      case '2':
        return 'Tuesday';
      case '3':
        return 'Wednesday';
      case '4':
        return 'Thursday';
      case '5':
        return 'Friday';
      case '6':
        return 'Saturday';
      case '7':
        return 'Sunday';
      default:
        return 'Unknown Day';
    }
  }

  static String getMostProductiveTime(List<Todo> completedTodos) {
    Map<String, int> timeCounts = {};
    for (var todo in completedTodos) {
      var hour = todo.completionDate!.hour.toString();
      timeCounts[hour] = (timeCounts[hour] ?? 0) + 1;
    }

    String mostProductiveTime =
        timeCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return '$mostProductiveTime:00';
  }
}
