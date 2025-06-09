import 'package:googleapis/calendar/v3.dart';
import 'package:taskhero/core/classes/todo.dart';
import 'package:taskhero/data/calendar/calendar_service.dart';

class CalendarClient {
  static CalendarApi? calendar;

  // For creating a new calendar event
  Future<void> insert(Todo todo, String calendarId) async {
    Event event = Event();

    event.id = todo.id;
    event.summary = todo.title;
    event.description = todo.description;
    event.attendees = [];
    event.location = '';

    EventDateTime start = EventDateTime();
    start.dateTime = DateTime(
      todo.date.year,
      todo.date.month,
      todo.date.day,
      0,
      0,
    );
    start.timeZone = "GMT+02:00";
    event.start = start;

    EventDateTime end = EventDateTime();
    end.timeZone = "GMT+02:00";
    end.dateTime = DateTime(
      todo.date.year,
      todo.date.month,
      todo.date.day,
      23,
      59,
    );
    event.end = end;

    await calendar?.events.insert(event, calendarId, sendUpdates: "none");
  }

  Future<void> delete(String eventId) async {
    // Check if the event exists return if not
    String calendarId = await CalendarService.createCustomCalendar();
    final eventList = await calendar?.events.list(calendarId);
    final existingEvent =
        eventList?.items?.where((event) => event.id == eventId).firstOrNull;
    if (existingEvent == null) {
      return;
    }
    // Delete the event
    await calendar?.events.delete(calendarId, eventId);
  }

  static Future<void> toggleStatus(String eventId) async {
    String calendarId = await CalendarService.createCustomCalendar();
    Event? event = await calendar?.events.get(calendarId, eventId);
    if (event == null) {
      return;
    }
    event.status = event.status == "cancelled" ? "confirmed" : "cancelled";
    await calendar?.events.update(event, calendarId, eventId);
  }
}
