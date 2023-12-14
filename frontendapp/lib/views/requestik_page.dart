import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/views/all_requestik_page.dart';
import 'package:frontendapp/views/form_ik.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IzinKeluarPage extends StatelessWidget {
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Izin Keluar'),
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
                  padding: EdgeInsets.all(12.0),
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
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Request IK',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'view_all',
                        child: Text('View All', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.blue) )
                      ),
                    ];
                  },
                  onSelected: (String value) {
                    if (value == 'view_all') {
                      Get.to(() => AllRequestIKPage());
                    }
                  },
                ),
              ],
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
                    itemCount: _requestIKController.requestIK.length > 6
                        ? 6
                        : _requestIKController.requestIK.length,
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

    return Card(
      color: backgroundColor,
      child: ListTile(
        title: Text(
          keperluan,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400),
        ),
        subtitle: Text('Status Request: $status'),
      ),
    );
  }
}
