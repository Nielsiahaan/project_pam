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
                      const DataColumn(label: Text('Kategori Surat')),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('Action')),
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
                            DataCell(Text(requestSurat.kategoriSurat)),
                            DataCell(Text(requestSurat.status)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      Get.bottomSheet(
                                          SuratView(requestId: requestSurat.id),
                                          isScrollControlled: true);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _adminController.approveSurat(
                                          id: requestSurat.id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Approve',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _adminController.rejectSurat(
                                          id: requestSurat.id);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Reject',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  )
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
