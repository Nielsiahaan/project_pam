import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/admin_controller.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:get/get.dart';

class SuratView extends StatelessWidget {
  final int requestId;

  const SuratView({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.put(AdminController());

    return GetBuilder<RequestSuratController>(
      builder: (controller) {
        var requestSuratView = controller.requestSurat
            .firstWhere((requestSurat) => requestSurat.id == requestId);
        // var roomName = controller.getRoomNameById(requestSuratView.id);
        return Center(
          child: Container(
            width: 350.0,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Detail Pemesanan Ruangan',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                buildDetailRow(
                  title: 'Nama Mahasiswa',
                  content: FutureBuilder<String>(
                    future: adminController
                        .getNamaMahasiswaFromId(requestSuratView.mahasiswaId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Colors.blueGrey,
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'N/A',
                          style: TextStyle(
                              fontSize: 16.0, color: Colors.teal[900]),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12.0),
                buildDetailText(
                  title: 'Jenis Surat',
                  content: requestSuratView.kategoriSurat,
                ),
                const SizedBox(height: 12.0),
                buildDetailText(
                  title: 'Status',
                  content: requestSuratView.status,
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (requestSuratView.status == 'pending')
                      buildActionButton(
                        onPressed: () {
                          adminController.approveSurat(id: requestSuratView.id);
                        },
                        label: 'Approve',
                        color: Colors.green,
                      ),
                    if (requestSuratView.status == 'pending')
                      buildActionButton(
                        onPressed: () {
                          adminController.rejectSurat(id: requestSuratView.id);
                        },
                        label: 'Reject',
                        color: Colors.red,
                      ),
                    buildActionButton(
                      onPressed: () {
                        Get.back();
                      },
                      label: 'Close',
                      color: Colors.blue,
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDetailRow({required String title, required Widget content}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
        ),
        const SizedBox(width: 8.0),
        Expanded(child: content),
      ],
    );
  }

  Widget buildDetailText({required String title, required String content}) {
    return Text(
      '$title: $content',
      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
    );
  }

  Widget buildActionButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        minimumSize: const Size(100, 0),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
