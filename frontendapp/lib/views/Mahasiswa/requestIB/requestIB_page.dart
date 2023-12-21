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
        backgroundColor: Colors.blue,
        title: Text(
          'Izin Bermalam',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => IzinBermalamForm());
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.green,
                ),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Request Izin Bermalam',
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
              'Riwayat Izin Bermalam',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Obx(() {
              if (_requestIBController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestIBController.requestIB.isEmpty) {
                return Center(child: Text('No izin bermalam available.'));
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
                  keperluan,
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w400),
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
                        value: 'cancel',
                        child: Text('Batal'),
                      ),
                  ],
                  onSelected: (String value) {
                    handlePopupMenuSelection(value, requestId);
                  },
                ),
              ],
            ),
            Text(tujuan,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400)),
          ],
        ),
        subtitle: Text(
          'Status: $status',
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
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
      title: 'Cancel Izin Bermalam',
      middleText: 'Are you sure you want to cancel the Request IB?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await _requestIBController.cancelRequestIB(requestId);
      },
    );
  }
}
