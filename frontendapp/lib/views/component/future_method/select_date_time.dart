import 'package:flutter/material.dart';

Future<void> selectDateTime(
  BuildContext context,
  DateTime selectedDateTime,
  Function(DateTime) updateDateTime,
) async {
  DateTime? pickedDateTime = await showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: Colors.teal[400],
          colorScheme: ColorScheme.light(primary: Colors.teal[400]!),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
        ),
        child: child!,
      );
    },
  );

  if (pickedDateTime != null) {
    TimeOfDay currentTime = TimeOfDay.fromDateTime(selectedDateTime);

    // ignore: use_build_context_synchronously
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal[400],
            // accentColor: Colors.teal[400],
            colorScheme: ColorScheme.light(primary: Colors.teal[400]!),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      updateDateTime(
        DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        ),
      );
    }
  }
}
