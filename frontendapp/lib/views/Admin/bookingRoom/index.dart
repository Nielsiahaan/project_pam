import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/detail_booking_room.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexBookingRoom extends StatelessWidget {
  IndexBookingRoom({Key? key}) : super(key: key);

  final BookingRoomController _bookingRoomController =
      Get.put(BookingRoomController());
  final AdminController _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
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
                return Center(child: CircularProgressIndicator());
              } else if (_bookingRoomController.bookingRoom.isEmpty) {
                return Center(
                    child: Text('No izin bermalam request available.'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('No')),
                      const DataColumn(label: Text('Nama Mahasiswa')),
                      const DataColumn(label: Text('Ruangan')),
                      const DataColumn(label: Text('Keterangan')),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(
                      _bookingRoomController.bookingRoom.length,
                      (index) {
                        var bookingRoom =
                            _bookingRoomController.bookingRoom[index];
                        String roomName = _bookingRoomController
                            .getRoomNameById(bookingRoom.id);
                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(FutureBuilder<String>(
                              future: _adminController.getNamaMahasiswaFromId(
                                  bookingRoom.mahasiswaId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text('Error');
                                } else {
                                  return Text(snapshot.data ?? 'Unknown');
                                }
                              },
                            )),
                            DataCell(Text(roomName)),
                            DataCell(Text(bookingRoom.keterangan)),
                            DataCell(Text(bookingRoom.status)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      Get.bottomSheet(
                                          BookingRoomDetailModal(
                                              requestId: bookingRoom.id),
                                          isScrollControlled: true);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _adminController.approveBookingRoom(
                                          id: bookingRoom.id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Approve',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _adminController.rejectBookingRoom(
                                          id: bookingRoom.id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Reject',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
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
