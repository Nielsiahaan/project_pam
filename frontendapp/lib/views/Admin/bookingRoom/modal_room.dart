import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoomView extends StatelessWidget {
  final int requestId;

  RoomView({required this.requestId});

  @override
  Widget build(BuildContext context) {
    final AdminController _adminController = Get.put(AdminController());

    return GetBuilder<BookingRoomController>(
      builder: (controller) {
        var bookingRoomView = controller.bookingRoom
            .firstWhere((bookingRoom) => bookingRoom.id == requestId);
        var roomName = controller.getRoomNameById(bookingRoomView.id);

        return Center(
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Detail Ruangan',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Mahasiswa    :   ',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        FutureBuilder<String>(
                          future: _adminController.getNamaMahasiswaFromId(
                              bookingRoomView.mahasiswaId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data ?? 'N/A',
                                style: const TextStyle(fontSize: 15.0),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Ruangan                    :   ${roomName}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Keterangan               :   ${bookingRoomView.keterangan}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Waktu Mulai             :   ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomView.startTime)}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Waktu Berakhir        :   ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomView.endTime)}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status                       :   ${bookingRoomView.status}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 50.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _adminController.approveBookingRoom(
                                  id: bookingRoomView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize: const Size(120, 0),
                            ),
                            child: const Text(
                              'Approve',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              _adminController.rejectBookingRoom(
                                  id: bookingRoomView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize: const Size(120, 0),
                            ),
                            child: const Text(
                              'Reject',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        minimumSize: const Size(double.infinity, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
