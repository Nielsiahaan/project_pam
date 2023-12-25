import 'package:flutter/material.dart';
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
=======
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/controllers/admin_controller.dart'; // Import the admin controller
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingRoomDetailModal extends StatelessWidget {
  final int requestId;

  BookingRoomDetailModal({required this.requestId});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
    return GetBuilder<BookingRoomController>(
=======
    final AdminController _adminController = Get.put(AdminController());

    return GetBuilder<RequestSuratController>(
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
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
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
                    Text(
                      'Detail Pemesanan Ruangan',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
=======
                    Center(
                      child: const Text(
                        'Detail Surat',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
                      'Ruangan: ${roomName}',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Keterangan: ${bookingRoomDetail.keterangan}',
=======
                      'Kategori Surat              : ${requestSuratView.kategoriSurat}',
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
                      'Waktu Mulai: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomDetail.startTime)}',
=======
                      'Keterangan                   : ${requestSuratView.content}',
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
                      'Waktu Berakhir: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(bookingRoomDetail.endTime)}',
=======
                      'Tanggal pengambilan  : ${DateFormat('yyyy-MM-dd HH:mm').format(requestSuratView.tanggalPengambilan)}',
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
<<<<<<< HEAD:frontendapp/lib/views/Mahasiswa/bookingRoom/detail_booking_room.dart
                      'Status: ${bookingRoomDetail.status}',
=======
                      'Status                            : ${requestSuratView.status}',
>>>>>>> 80eab21dae64762d09bdaea117b304379be348de:frontendapp/lib/views/Admin/requestSurat/modal_surat.dart
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 50.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Mengatur tombol di tengah
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _adminController.approveSurat(
                                  id: requestSuratView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize:
                                  Size(120, 0), // Atur panjang tombol di sini
                            ),
                            child: Text(
                              'Approve',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              _adminController.rejectSurat(
                                  id: requestSuratView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize:
                                  Size(120, 0), // Atur panjang tombol di sini
                            ),
                            child: Text(
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
                        primary: Colors.blue, // Ganti warna sesuai kebutuhan
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        minimumSize:
                            Size(double.infinity, 0), // Panjang tombol memenuhi
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Mengatur kotak lengkung
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
