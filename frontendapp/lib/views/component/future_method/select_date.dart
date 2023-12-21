// select_date.dart
import 'package:flutter/material.dart';

Future<void> selectDate(
  BuildContext context,
  DateTime selectedDateTime,
  Function(DateTime) updateDateTime,
) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null && pickedDate != selectedDateTime) {
    updateDateTime(
      DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedDateTime.hour,
        selectedDateTime.minute,
      ),
    );
  }
}
