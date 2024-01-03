import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookingForm extends StatefulWidget {
  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final BookingRoomController _bookingController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _keteranganController = TextEditingController();

  DateTime _selectedStartTime = DateTime.now();

  DateTime _selectedEndTime = DateTime.now().add(Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDateTimePicker(
                    label: 'Start Date and Time',
                    selectedDateTime: _selectedStartTime,
                    onTap: () => _selectDateTime(context, true),
                  ),
                  SizedBox(height: 16.0),
                  buildDateTimePicker(
                    label: 'End Date and Time',
                    selectedDateTime: _selectedEndTime,
                    onTap: () => _selectDateTime(context, false),
                  ),
                  SizedBox(height: 16.0),
                  buildRoomDropdown(),
                  SizedBox(height: 16.0),
                  buildDescriptionTextField(),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _bookingController.createBookingRoom(
                              roomId: _bookingController.selectedRoomId.value,
                              startTime: _selectedStartTime,
                              endTime: _selectedEndTime,
                              keterangan: _keteranganController.text,
                            );
                          }
                        },
                        child: Text('Submit', style: GoogleFonts.inter(fontSize: 16, color: Colors.white, ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel', style: GoogleFonts.inter(fontSize: 16, color: Colors.white, ),),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateTimePicker({
    required String label,
    required DateTime selectedDateTime,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime),
            ),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget buildRoomDropdown() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: DropdownButtonFormField<int>(
        value: _bookingController.rooms.isNotEmpty
            ? _bookingController.rooms.first.id
            : null,
        decoration: InputDecoration.collapsed(hintText: 'Select a Room'),
        items: _bookingController.rooms
            .map(
              (room) => DropdownMenuItem<int>(
                value: room.id,
                child: Text(room.roomName),
              ),
            )
            .toList(),
        onChanged: (value) {
          _bookingController.selectedRoomId.value = value!;
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a room';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDescriptionTextField() {
    return TextFormField(
      controller: _keteranganController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    DateTime currentDate = isStartTime ? _selectedStartTime : _selectedEndTime;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (isStartTime) {
          _selectedStartTime = combinedDateTime;
        } else {
          _selectedEndTime = combinedDateTime;
        }

        Get.forceAppUpdate();
      }
    }
  }
}
