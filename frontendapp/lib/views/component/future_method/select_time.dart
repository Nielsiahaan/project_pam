// select_time.dart
import 'package:flutter/material.dart';

Future<void> selectTime(
  BuildContext context,
  bool isRencanaBerangkat,
  DateTime selectedDateTime,
  Function(DateTime) updateDateTime,
) async {
  TimeOfDay currentTime = TimeOfDay.fromDateTime(selectedDateTime);

  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: currentTime,
  );

  if (pickedTime != null) {
    updateDateTime(
      DateTime(
        selectedDateTime.year,
        selectedDateTime.month,
        selectedDateTime.day,
        pickedTime.hour,
        pickedTime.minute,
      ),
    );
  }
}
