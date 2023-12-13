// 
import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
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
                  'All Request IK',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    // Redirect to a new page to display all requests
                    // Implement the navigation logic based on your requirement
                  },
                  child: Icon(Icons.more_horiz),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Obx(() {
              return _requestIKController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
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
            }),
          ],
        ),
      ),
    );
  }

  Widget buildIzinTile({required String keperluan, required String status}) {
    return Card(
      child: ListTile(
        title: Text(
          keperluan,
          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400),
        ),
        subtitle: Text('Status Request: $status'),
        // Tambahkan aksi lainnya jika diperlukan
      ),
    );
  }
}
