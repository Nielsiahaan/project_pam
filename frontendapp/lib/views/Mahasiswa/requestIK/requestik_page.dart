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
        backgroundColor: Colors.blue,
        title: Text(
          'Izin Keluar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => IzinKeluarForm());
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.green,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: const Center(
                    child: Text(
                      'Request Izin Keluar',
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
              'Riwayat Izin Keluar',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Obx(() {
              if (_requestIKController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestIKController.requestIK.isEmpty) {
                return Center(child: Text('No Request IK available.'));
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
                Flexible(
                  child: Text(
                    "Alasan: ${keperluan}",
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
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
                )
              ],
            ),
          ],
        ),
        subtitle: Text('Status: $status',
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400)),
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
      title: 'Cancel Izin keluar',
      middleText: 'Are you sure you want to cancel the Request IK?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await _requestIKController.cancelRequestIK(requestId);
      },
    );
  }
}
