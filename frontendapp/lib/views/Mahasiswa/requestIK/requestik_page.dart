import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/detail_Ik.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/form_ik.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinKeluarPage extends StatelessWidget {
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[400],
        title: Text(
          'Izin Keluar',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => IzinKeluarForm());
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
                    'Request Izin Keluar',
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
              'Riwayat Izin Keluar',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[400],
              ),
            ),
            const SizedBox(height: 8.0),
            Obx(() {
              if (_requestIKController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_requestIKController.requestIK.isEmpty) {
                return const Center(child: Text('No Request IK available.'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _requestIKController.requestIK.length,
                    itemBuilder: (context, index) {
                      var requestIK = _requestIKController.requestIK[index];
                      return buildIzinTile(
                        keperluan: requestIK.deskripsi,
                        status: requestIK.status,
                        requestId: requestIK.id,
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
    required String keperluan,
    required String status,
    required int requestId,
  }) {
    Color? backgroundColor;
    late Color textColor;

    switch (status.toLowerCase()) {
      case 'rejected':
        backgroundColor = Colors.red[300];
        textColor = Colors.white;
        break;
      case 'pending':
        backgroundColor = Colors.yellow[100];
        textColor = Colors.deepOrange[300]!;
        break;
      case 'approved':
        backgroundColor = Colors.green[100];
        textColor = Colors.green[700]!;
        break;
      default:
        backgroundColor = Colors.grey[200];
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
                Flexible(
                  child: Text(
                    "Alasan: $keperluan",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
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
                        value: 'cancel',
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
                    handlePopupMenuSelection(value, requestId);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.teal[400],
                  ),
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              'Status: $status',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handlePopupMenuSelection(String value, int requestId) {
    switch (value) {
      case 'view':
        Get.bottomSheet(
          IzinKeluarDetailModal(requestId: requestId),
          isScrollControlled: true,
        );
        break;
      case 'cancel':
        cancelRequestIK(requestId);
        break;
      default:
    }
  }

  void cancelRequestIK(int requestId) {
    Get.defaultDialog(
      title: 'Batal Izin Keluar',
      middleText: 'Apakah Anda yakin ingin membatalkan Permintaan Izin Keluar?',
      textCancel: 'Tidak',
      textConfirm: 'Ya',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.blueGrey,
      buttonColor: Colors.blueGrey,
      onConfirm: () async {
        await _requestIKController.cancelRequestIK(requestId);
      },
    );
  }
}
