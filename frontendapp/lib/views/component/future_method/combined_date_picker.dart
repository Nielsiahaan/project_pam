import 'package:flutter/material.dart';
import 'package:frontendapp/views/component/future_method/select_date_time.dart';

class CombinedDateTimePicker extends StatelessWidget {
  final String title;
  final DateTime selectedDateTime;
  final Function(DateTime) updateDateTime;

  const CombinedDateTimePicker({
    super.key,
    required this.title,
    required this.selectedDateTime,
    required this.updateDateTime,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectDateTime(context, selectedDateTime, updateDateTime),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: title,
          hintText: 'Pilih Tanggal dan Waktu',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.teal[400]!, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal[400]!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[400]!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${"${selectedDateTime.toLocal()}".split(' ')[0]} ${"${selectedDateTime.toLocal()}".split(' ')[1].substring(0, 5)}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.teal[400],
              ),
            ),
            Icon(Icons.calendar_today, color: Colors.teal[400]),
          ],
        ),
      ),
    );
  }
}
