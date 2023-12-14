import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllRequestIKPage extends StatelessWidget {
  AllRequestIKPage({super.key});
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Izin Keluar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'List Request IK',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
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

  Widget buildIzinTile({required String keperluan, required String status}) {
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: backgroundColor,
        child: ListTile(
          title: Text(
            keperluan,
            style:
                GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            'Status Request: $status',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
