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
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[400],
        title: Text(
          'Booking Room',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => BookingForm());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    'Booking Room',
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Riwayat Booking Room',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[400],
              ),
            ),
            const SizedBox(height: 8.0),
            Obx(() {
              if (_bookingController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_bookingController.bookingRoom.isEmpty) {
                return Center(
                    child: Text(
                  'No booking room available.',
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[400],
                  ),
                ));
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
                        status: bookingRoom.status,
                      );
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
    String roomName = _bookingController.getRoomNameById(roomId);
    late Color backgroundColor;
    late Color textColor;

    switch (status.toLowerCase()) {
      case 'rejected':
        backgroundColor = Colors.red[300]!;
        textColor = Colors.white;
        break;
      case 'pending':
        backgroundColor = Colors.yellow[100]!;
        textColor = Colors.deepOrange[300]!;
        break;
      case 'approved':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[700]!;
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.blueGrey;
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
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'view',
                      child: Text(
                        'View Detail',
                        style: TextStyle(
                          color: Colors.teal[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (status.toLowerCase() == 'pending')
                      PopupMenuItem<String>(
                        value: 'batal',
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            color: Colors.red[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                  onSelected: (String value) {
                    handlePopupMenuSelection(value, roomId);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.teal[400],
                  ),
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            Text(
              'Waktu Mulai: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(start_time)}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            Text(
              'Waktu Berakhir: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(end_time)}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Status: $status',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColor,
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
      cancelTextColor: Colors.blueGrey,
      buttonColor: Colors.blueGrey,
      onConfirm: () async {
        //call the cancelBooking  method
        await _bookingController.cancelBooking(roomId);
      },
    );
  }
}
