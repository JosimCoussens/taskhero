import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskhero/ui/widgets.dart';
import 'package:taskhero/core/constants.dart';

Future<dynamic> showCalendar(BuildContext context) {
  DateTime? selectedDate;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const WindowHeader(title: "Set Task Date"),
            SfDateRangePicker(
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionColor: AppColors.primaryLight,
              todayHighlightColor: AppColors.primaryLighter,
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  selectedDate = args.value;
                }
              },
            ),
            const SizedBox(height: 8),
            Components().buttons(
              context,
              () => Navigator.pop(context),
              () => Navigator.pop(context, selectedDate),
            ),
          ],
        ),
      );
    },
  );
}
