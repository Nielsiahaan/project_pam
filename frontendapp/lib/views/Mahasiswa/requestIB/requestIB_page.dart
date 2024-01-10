import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/detail_IB.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/form_ib.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinBermalamPage extends StatelessWidget {
  final RequestIBController _requestIBController =
      Get.put(RequestIBController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Izin Bermalam',
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
                Get.to(() => IzinBermalamForm());
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
                    'Request Izin Bermalam',
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
              'Riwayat Izin Bermalam',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[400],
              ),
            ),
            const SizedBox(height: 8.0),
            Obx(() {
              if (_requestIBController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_requestIBController.requestIB.isEmpty) {
                return Center(
                    child: Text(
                  'No izin bermalam available.',
                  style: GoogleFonts.poppins(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[400],
                  ),
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _requestIBController.requestIB.length,
                    itemBuilder: (context, index) {
                      var requestIB = _requestIBController.requestIB[index];
                      return buildIzinTile(
                        keperluan: requestIB.deskripsi,
                        tujuan: requestIB.tujuan,
                        status: requestIB.status,
                        requestId: requestIB.id,
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
    required String tujuan,
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
                    style: GoogleFonts.poppins(
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
            const SizedBox(height: 4),
            Text(
              'Tujuan: $tujuan',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
          ],
        ),
        subtitle: Text(
          'Status: $status',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
      ),
    );
  }

  void handlePopupMenuSelection(String value, int requestId) {
    switch (value) {
      case 'view':
        Get.bottomSheet(
          IzinBermalamDetailModal(requestId: requestId),
          isScrollControlled: true,
        );
        break;
      case 'cancel':
        cancelRequestIB(requestId);
        break;
      default:
    }
  }

  void cancelRequestIB(int requestId) {
    Get.defaultDialog(
      title: 'Batal Izin Bermalam',
      middleText:
          'Apakah Anda yakin ingin membatalkan Permintaan Izin Bermalam?',
      textCancel: 'Tidak',
      textConfirm: 'Ya',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.blueGrey,
      buttonColor: Colors.blueGrey,
      onConfirm: () async {
        await _requestIBController.cancelRequestIB(requestId);
      },
    );
  }
}
