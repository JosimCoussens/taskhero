import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/calendar/calendar_client.dart';

class CalendarService {
  static Future<void> createEvent(Todo todo) async {
    CalendarClient calendarClient = CalendarClient();
    String calendarId = await CalendarService.createCustomCalendar();
    await calendarClient.insert(todo, calendarId);
  }

  static Future<void> deleteEvent(String eventId) async {
    CalendarClient calendarClient = CalendarClient();
    await calendarClient.delete(eventId);
  }

  static Future<String> createCustomCalendar() async {
    // Check if the calendar already exists
    final calendarList = await CalendarClient.calendar!.calendarList.list();
    final existingCalendar =
        calendarList.items
            ?.where((calendar) => calendar.summary == AppParams.calendarName)
            .firstOrNull;
    if (existingCalendar != null) {
      return existingCalendar.id!;
    }

    final newCalendar =
        cal.Calendar()
          ..summary = AppParams.calendarName
          ..timeZone = "GMT+05:30";

    final createdCalendar = await CalendarClient.calendar!.calendars.insert(
      newCalendar,
    );
    return createdCalendar.id!; // Save this ID and use it for event creation
  }

  static void updateEventDate(Todo todo) async {
    CalendarClient calendarClient = CalendarClient();
    calendarClient.updateDate(todo);
  }
}
