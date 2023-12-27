import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/views/Admin/bookingRoom/modal_room.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexBookingRoom extends StatelessWidget {
  IndexBookingRoom({Key? key}) : super(key: key);

  final BookingRoomController _bookingRoomController =
      Get.put(BookingRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Index Pemesanan Ruangan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Riwayat Pemesanan Ruangan',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (_bookingRoomController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_bookingRoomController.bookingRoom.isEmpty) {
                return const Center(
                    child: Text('No izin bermalam request available.'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    horizontalMargin: MediaQuery.of(context).size.width *0.1, // Adjust the percentage as needed
                      columnSpacing: 65.0, // Adjust the spacing between columns
                    columns: [
                      const DataColumn(label: Text('No'), numeric: true),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('Detail Ruangan')),
                    ],
                    rows: List<DataRow>.generate(
                      _bookingRoomController.bookingRoom.length,
                      (index) {
                        var bookingRoom =
                            _bookingRoomController.bookingRoom[index];
                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(bookingRoom.status)), 
                            DataCell(
                              Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          RoomView(requestId: bookingRoom.id),
                                          isScrollControlled: true,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                      ),
                                      child: const Text("Detail",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
