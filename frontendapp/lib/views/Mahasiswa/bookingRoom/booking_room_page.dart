import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/detail_booking_room.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/form_bookingRoom.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BookingRoomPage extends StatelessWidget {
  final BookingRoomController _bookingController =
      Get.put(BookingRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Booking Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => BookingForm());
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.green,
                ),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Booking Room',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Riwayat Booking Room',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Obx(() {
              if (_bookingController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_bookingController.bookingRoom.isEmpty) {
                return Center(child: Text('No booking room available.'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _bookingController.bookingRoom.length,
                    itemBuilder: (context, index) {
                      var bookingRoom = _bookingController.bookingRoom[index];
                      return buildIzinTile(
                          roomId: bookingRoom.roomId,
                          start_time: bookingRoom.startTime,
                          end_time: bookingRoom.endTime,
                          status: bookingRoom.status);
                    },
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget buildIzinTile({
    required int roomId,
    required DateTime start_time,
    required DateTime end_time,
    required String status,
  }) {
    Color? backgroundColor;

    String roomName = _bookingController.getRoomNameById(roomId);

    switch (status.toLowerCase()) {
      case 'rejected':
        backgroundColor = Colors.red[100];
        break;
      case 'pending':
        backgroundColor = Colors.yellow[100];
        break;
      case 'approved':
        backgroundColor = Colors.green[100];
        break;
      default:
        backgroundColor = Colors.grey[300];
    }

    return Card(
      color: backgroundColor,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'view',
                      child: Text('View Detail'),
                    ),
                    if (status.toLowerCase() == 'pending')
                      const PopupMenuItem<String>(
                        value: 'batal',
                        child: Text('Batal'),
                      ),
                  ],
                  onSelected: (String value) {
                    handlePopupMenuSelection(value, roomId);
                  },
                ),
              ],
            ),
            Text(
              'Waktu Mulai: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(start_time)}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Waktu Berakhir: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(end_time)}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Status: $status',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void handlePopupMenuSelection(String value, int roomId) {
    switch (value) {
      case 'view':
        Get.bottomSheet(
          BookingRoomDetailModal(requestId: roomId),
           isScrollControlled: true,
        );
        break;
      case 'batal':
        cancelBooking(roomId);
        break;
    }
  }

  void cancelBooking(int roomId) {
    var roomName = _bookingController.getRoomNameById(roomId);

    //show a confirmation dialog
    Get.defaultDialog(
      title: 'Cancel Booking',
      middleText: 'Are you sure you want to cancel the booking for $roomName?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        //call the cancelBooking  method
        await _bookingController.cancelBooking(roomId);
      },
    );
  }
}
