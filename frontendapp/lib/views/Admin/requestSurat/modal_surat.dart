import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuratView extends StatelessWidget {
  final int requestId;

  SuratView({required this.requestId});

  @override
  Widget build(BuildContext context) {
    final AdminController _adminController = Get.put(AdminController());

    return GetBuilder<RequestSuratController>(
      builder: (controller) {
        var requestSuratView = controller.requestSurat
            .firstWhere((requestSurat) => requestSurat.id == requestId);

        return Center(
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Detail Surat',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nama Mahasiswa        :   ',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        FutureBuilder<String>(
                          future: _adminController.getNamaMahasiswaFromId(
                              requestSuratView.mahasiswaId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                snapshot.data ?? 'N/A',
                                style: const TextStyle(fontSize: 15.0),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Kategori Surat              :   ${requestSuratView.kategoriSurat}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Keterangan                   :   ${requestSuratView.content}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Tanggal pengambilan  :   ${DateFormat('yyyy-MM-dd HH:mm').format(requestSuratView.tanggalPengambilan)}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status                            :   ${requestSuratView.status}',
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(height: 50.0),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _adminController.approveSurat(
                                  id: requestSuratView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize: const Size(120, 0),
                            ),
                            child: const Text(
                              'Approve',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              _adminController.rejectSurat(
                                  id: requestSuratView.id);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              minimumSize: const Size(120, 0),
                            ),
                            child: const Text(
                              'Reject',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        minimumSize: const Size(double.infinity, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
