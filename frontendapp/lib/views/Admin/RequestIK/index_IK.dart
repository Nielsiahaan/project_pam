import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/views/Admin/RequestIK/modal_IK.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexIzinKeluar extends StatelessWidget {
  IndexIzinKeluar({Key? key}) : super(key: key);

  final RequestIKController _requestIKController =
      Get.put(RequestIKController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Index Izin Keluar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Riwayat Izin Keluar',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (_requestIKController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestIKController.requestIK.isEmpty) {
                return Center(
                    child: Text('No izin keluar requests available.'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    horizontalMargin: MediaQuery.of(context).size.width *
                        0.1, // Adjust the percentage as needed
                    columnSpacing: 65.0, // Adjust the spacing between columns
                    columns: [
                      const DataColumn(label: Text('No'), numeric: true),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('Detail Ruangan')),
                    ],
                    rows: List<DataRow>.generate(
                      _requestIKController.requestIK.length,
                      (index) {
                        var requestik = _requestIKController.requestIK[index];

                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(requestik.status)),
                            DataCell(
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        IbView(requestId: requestik.id),
                                        isScrollControlled: true,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                    ),
                                    child: const Text("Detail",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
