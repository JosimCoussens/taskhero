import 'package:flutter/material.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/todo_service.dart';

class DayBubble extends StatefulWidget {
  final DateTime day;
  final String dayName;
  final String dayNumber;
  final bool isSelected;
  final bool isWeekend;
  final bool isToday;

  const DayBubble({
    super.key,
    required this.day,
    required this.dayName,
    required this.dayNumber,
    required this.isSelected,
    required this.isWeekend,
    required this.isToday,
  });

  @override
  State<DayBubble> createState() => _DayBubbleState();
}

class _DayBubbleState extends State<DayBubble> {
  @override
  Widget build(BuildContext context) {
    final Color textColor =
        widget.isSelected
            ? Colors.blue
            : widget.isWeekend
            ? Colors.red
            : Colors.white;

    return Column(
      children: [
        Text(
          widget.dayName,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isSelected ? Colors.white : Colors.transparent,
            border:
                widget.isToday
                    ? Border.all(color: AppColors.primaryLight, width: 2)
                    : null,
            boxShadow:
                widget.isSelected
                    ? [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.dayNumber,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                FutureBuilder(
                  future: TodoService.getTodoAmount(widget.day),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < snapshot.data!; i++)
                              // Show max 3 dots
                              if (i <= 4)
                                Icon(
                                  Icons.circle,
                                  color: Colors.green,
                                  size: 8,
                                ),
                          ],
                        )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
