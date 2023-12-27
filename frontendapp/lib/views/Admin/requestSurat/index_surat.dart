import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/views/Admin/requestSurat/modal_surat.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexSurat extends StatelessWidget {
  IndexSurat({Key? key}) : super(key: key);

  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Index Request Surat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Riwayat Request Surat',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (_requestSuratController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_requestSuratController.requestSurat.isEmpty) {
                return const Center(
                    child: Text('No surat requests available.'));
              } else {
                return Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      horizontalMargin: MediaQuery.of(context).size.width *
                          0.1, // Adjust the percentage as needed
                      columnSpacing: 65.0, // Adjust the spacing between columns
                      columns: const [
                        DataColumn(
                          label: Text('No'),
                          numeric: true,
                        ),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Detail Surat')),
                      ],
                      rows: List<DataRow>.generate(
                        _requestSuratController.requestSurat.length,
                        (index) {
                          var requestSurat =
                              _requestSuratController.requestSurat[index];

                          return DataRow(
                            cells: [
                              DataCell(Text((index + 1).toString())),
                              DataCell(Text(requestSurat.status)),
                              DataCell(
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          SuratView(requestId: requestSurat.id),
                                          isScrollControlled: true,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                      ),
                                      child: const Text("Detail",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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
