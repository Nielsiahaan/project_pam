import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/detail_IB.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexIzinBermalam extends StatelessWidget {
  IndexIzinBermalam({Key? key}) : super(key: key);

  final RequestIBController _requestIBController =
      Get.put(RequestIBController());
  final AdminController _adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
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
            SizedBox(height: 16),
            Obx(() {
              if (_requestIBController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_requestIBController.requestIB.isEmpty) {
                return Center(
                    child: Text('No izin bermalam request available.'));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      const DataColumn(label: Text('No')),
                      const DataColumn(label: Text('Nama Mahasiswa')),
                      const DataColumn(label: Text('Keperluan IB')),
                      const DataColumn(label: Text('Status')),
                      const DataColumn(label: Text('Action')),
                    ],
                    rows: List<DataRow>.generate(
                      _requestIBController.requestIB.length,
                      (index) {
                        var requestib = _requestIBController.requestIB[index];

                        return DataRow(
                          cells: [
                            DataCell(Text((index + 1).toString())),
                            DataCell(FutureBuilder<String>(
                              future: _adminController.getNamaMahasiswaFromId(
                                  requestib.mahasiswaId),
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
                            DataCell(Text(requestib.deskripsi)),
                            DataCell(Text(requestib.status)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.visibility),
                                    onPressed: () {
                                      Get.bottomSheet(
                                          IzinBermalamDetailModal(
                                              requestId: requestib.id),
                                          isScrollControlled: true);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _adminController.approveIB(
                                          id: requestib.id);
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
                                      _adminController.rejectIB(
                                          id: requestib.id);
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