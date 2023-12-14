import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/views/form_surat.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SuratRequestPage extends StatelessWidget {
  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Request Surat',
          style: GoogleFonts.poppins(),
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
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Riwayat Request Surat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
}

Widget buildRequestContainer({
  required String kategori_surat,
  required String deskripsi,
  required DateTime tanggal_pengambilan,
  required String status,
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
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
      color: backgroundColor,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori Surat: $kategori_surat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Deskripsi: $deskripsi'),
        SizedBox(height: 8),
        Text('Tanggal Pengambilan: ${tanggal_pengambilan.toLocal()}'),
        SizedBox(height: 8),
        Text('Status: $status'),
      ],
    ),
  );
}
