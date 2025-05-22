import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';
import 'package:taskhero/ui/header/header.dart';

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
                    spacing: AppParams.generalSpacing,
                    children: [
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            await TodoService().deleteCompleted();
                          },
                          child: const Text(
                            'Delete All Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
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
