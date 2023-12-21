import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/form_surat.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuratRequestPage extends StatelessWidget {
  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Request Surat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => SuratFormPage());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Request Surat',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Riwayat Request Surat',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (_requestSuratController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestSuratController.requestSurat.isEmpty) {
                return Center(child: Text('No surat requests available.'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _requestSuratController.requestSurat.length,
                    itemBuilder: (context, index) {
                      var requestSurat =
                          _requestSuratController.requestSurat[index];

                      return buildRequestContainer(
                        kategori_surat: requestSurat.kategoriSurat,
                        deskripsi: requestSurat.content,
                        tanggal_pengambilan: requestSurat.tanggalPengambilan,
                        status: requestSurat.status,
                        requestId: requestSurat.id,
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget buildRequestContainer({
    required String kategori_surat,
    required String deskripsi,
    required DateTime tanggal_pengambilan,
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
        backgroundColor = Colors.white;
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
                  'Kategori Surat: $kategori_surat',
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
            Text(
              'Status: $status',
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w400),
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
          SuratDetailModal(requestId: requestId),
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
        await _requestSuratController.cancelSurat(requestId);
      },
    );
  }
}
