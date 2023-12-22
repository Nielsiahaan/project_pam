import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SuratView extends StatelessWidget {
  final int requestId;

  SuratView({required this.requestId});

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'Detail Surat',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Kategori Surat: ${requestSuratView.kategoriSurat}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Keterangan: ${requestSuratView.content}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                        'Tanggal pengambilan: ${DateFormat('yyyy-MM-dd HH:mm').format(requestSuratView.tanggalPengambilan)}'),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${requestSuratView.status}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
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
}
