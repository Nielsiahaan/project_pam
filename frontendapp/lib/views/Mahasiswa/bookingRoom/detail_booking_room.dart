import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingRoomDetailModal extends StatelessWidget {
  final int requestId;

  BookingRoomDetailModal({required this.requestId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingRoomController>(
      builder: (controller) {
        var bookingRoomDetail = controller.bookingRoom
            .firstWhere((bookingRoom) => bookingRoom.id == requestId);
        var roomName = controller.getRoomNameById(bookingRoomDetail.id);
        return Center(
          child: Wrap(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Pemesanan Ruangan',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Ruangan: ${roomName}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Keterangan: ${bookingRoomDetail.keterangan}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Waktu Mulai: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomDetail.startTime)}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Waktu Berakhir: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomDetail.endTime)}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${bookingRoomDetail.status}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('Close'),
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
