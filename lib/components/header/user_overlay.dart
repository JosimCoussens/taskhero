import 'package:flutter/material.dart';
import 'package:taskhero/auth.dart';
import 'package:taskhero/calendar_client.dart';
import 'package:taskhero/components/header/header.dart';
import 'package:taskhero/pages/login_page.dart';

OverlayEntry userOverlay(
  Offset offset,
  Function removeOverlay,
  AppHeader widget,
  String userEmail,
) {
  return OverlayEntry(
    builder:
        (context) => Stack(
          children: [
            GestureDetector(
              onTap: () => removeOverlay(),
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: offset.dy + widget.preferredSize.height,
              right: 16,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userEmail,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _createEvent,
                        child: const Text('Create Event'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          removeOverlay();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                          await Auth().signOut();
                        },
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
  );
}

Future<void> _createEvent() async {
  CalendarClient calendarClient = CalendarClient();
  await calendarClient.insert(
    title: 'test2',
    description: 'test',
    location: '',
    attendeeEmailList: [],
    shouldNotifyAttendees: false,
    // Start of the day
    startTime: DateTime.now(),
    // End of the day
    endTime: DateTime.now().add(const Duration(hours: 1)),
  );
}
