import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/views/Admin/bookingRoom/view_booking_room.dart';
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
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo[600],
        title: Text(
          'Riwayat Izin Bermalam',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              if (_bookingRoomController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_bookingRoomController.bookingRoom.isEmpty) {
                return Center(
                    child: Text(
                  'Belum ada pemesanan ruangan.☹️',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    horizontalMargin: MediaQuery.of(context).size.width * 0.1,
                    columnSpacing: 65.0,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Detail',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      _bookingRoomController.bookingRoom.length,
                      (index) {
                        var bookingRoom =
                            _bookingRoomController.bookingRoom[index];
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                bookingRoom.status,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    BookingRoomView(requestId: bookingRoom.id),
                                    isScrollControlled: true,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
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
