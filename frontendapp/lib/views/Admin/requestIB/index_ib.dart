import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/Admin/requestIB/modal_IB.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexIzinBermalam extends StatelessWidget {
  IndexIzinBermalam({Key? key}) : super(key: key);

  final RequestIBController _requestIBController =
      Get.put(RequestIBController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Index Izin Bermalam',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Riwayat Izin Bermalam',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (_requestIBController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_requestIBController.requestIB.isEmpty) {
                return const Center(
                    child: Text('No izin bermalam request available.'));
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
                      const DataColumn(label: Text('Detail IB')),
                    ],
                    rows: List<DataRow>.generate(
                      _requestIBController.requestIB.length,
                      (index) {
                        var requestib = _requestIBController.requestIB[index];
                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(requestib.status)),
                            DataCell(
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        IbView(requestId: requestib.id),
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
