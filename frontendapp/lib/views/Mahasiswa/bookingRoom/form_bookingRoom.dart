import 'package:flutter/material.dart';
import 'package:frontendapp/views/component/future_method/combined_date_picker.dart';
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
  DateTime _selectedEndTime = DateTime.now().add(const Duration(hours: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[400],
        title: Text(
          'Booking Form',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  CombinedDateTimePicker(
                    title: 'Start Date and Time',
                    selectedDateTime: _selectedStartTime,
                    updateDateTime: (DateTime dateTime) {
                      setState(() {
                        _selectedStartTime = dateTime;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CombinedDateTimePicker(
                    title: 'End Date and Time',
                    selectedDateTime: _selectedEndTime,
                    updateDateTime: (DateTime dateTime) {
                      setState(() {
                        _selectedEndTime = dateTime;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  buildRoomDropdown(),
                  const SizedBox(height: 16.0),
                  buildDescriptionTextField(),
                  const SizedBox(height: 24.0),
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
                        child: Text(
                          'Submit',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.teal[50],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime),
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

  Widget buildRoomDropdown() {
    return DropdownButtonFormField<int>(
        value: _bookingController.rooms.isNotEmpty
            ? _bookingController.rooms.first.id
            : null,
        decoration: InputDecoration(
          hintText: 'Select a Room',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.teal[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal[400]!, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        items: _bookingController.rooms
            .map(
              (room) => DropdownMenuItem<int>(
                value: room.id,
                child: Text(
                  room.roomName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.teal[400],
                  ),
                ),
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
        });
  }

  Widget buildDescriptionTextField() {
    return TextFormField(
      controller: _keteranganController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Description',
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.teal[400],
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
        // filled: true,
        // fillColor: Colors.teal[50],
      ),
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.teal[400],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    );
  }
}
