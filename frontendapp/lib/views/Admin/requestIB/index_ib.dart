import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/views/Admin/requestIB/view_ib.dart';
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
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo[600],
        title: Text(
          'Riwayat Izin Bermalam',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              if (_requestIBController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_requestIBController.requestIB.isEmpty) {
                return Center(
                    child: Text(
                  'Belum ada permintaan izin bermalam.☹️',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ));
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    horizontalMargin: MediaQuery.of(context).size.width * 0.1,
                    columnSpacing: 65.0,
                    columns: const [
                      DataColumn(
                        label: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Detail',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      _requestIBController.requestIB.length,
                      (index) {
                        var requestIB = _requestIBController.requestIB[index];
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                requestIB.status,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  Get.bottomSheet(
                                    IbView(requestId: requestIB.id),
                                    isScrollControlled: true,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
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
