import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/views/Admin/requestSurat/modal_surat.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexSurat extends StatelessWidget {
  IndexSurat({Key? key}) : super(key: key);

  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());
  final AdminController _adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
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
            SizedBox(height: 16),
            Obx(() {
              if (_requestSuratController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestSuratController.requestSurat.isEmpty) {
                return Center(child: Text('No surat requests available.'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('No')),
                      const DataColumn(label: Text('Nama Mahasiswa')),
                      const DataColumn(label: Text('Detail Surat')),
                    ],
                    rows: List<DataRow>.generate(
                      _requestSuratController.requestSurat.length,
                      (index) {
                        var requestSurat =
                            _requestSuratController.requestSurat[index];

                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(FutureBuilder<String>(
                              future: _adminController.getNamaMahasiswaFromId(
                                  requestSurat.mahasiswaId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return const Text('Error');
                                } else {
                                  return Text(snapshot.data ?? 'Unknown');
                                }
                              },
                            )),
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
                                      primary: Colors
                                          .blue, // Sesuaikan dengan warna latar belakang yang diinginkan
                                    ),
                                    child: Text("Detail",
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
