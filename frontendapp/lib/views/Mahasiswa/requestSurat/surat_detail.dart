import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuratDetailModal extends StatelessWidget {
  final int requestId;

  const SuratDetailModal({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestSuratController>(
      builder: (controller) {
        var suratRequestDetail = controller.requestSurat
            .firstWhere((suratRequest) => suratRequest.id == requestId);

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
                    Text(
                      'Detail Request Surat',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Kategori Surat: ${suratRequestDetail.kategoriSurat}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Keterangan: ${suratRequestDetail.content}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Tanggal Pengambilan: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(suratRequestDetail.tanggalPengambilan)}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${suratRequestDetail.status}',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: getStatusColor(suratRequestDetail.status)),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal[700],
                      ),
                      child: const Text('Close'),
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'rejected':
        return Colors.red[700]!;
      case 'pending':
        return Colors.deepOrange[700]!;
      case 'approved':
        return Colors.green[700]!;
      default:
        return Colors.teal[900]!;
    }
  }
}
