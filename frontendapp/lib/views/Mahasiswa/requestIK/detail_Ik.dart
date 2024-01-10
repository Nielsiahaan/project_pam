import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IzinKeluarDetailModal extends StatelessWidget {
  final int requestId;

  const IzinKeluarDetailModal({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestIKController>(
      builder: (controller) {
        var requestIKDetail = controller.requestIK
            .firstWhere((requestik) => requestik.id == requestId);

        return Center(
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
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
                      'Detail Izin Keluar',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[900],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Alasan: ${requestIKDetail.deskripsi}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      'Tanggal Berangkat: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(requestIKDetail.tanggalBerangkat)}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Tanggal Kembali: ${DateFormat('yyyy-MM-dd HH:mm WIB').format(requestIKDetail.tanggalKembali)}',
                      style: TextStyle(fontSize: 16.0, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${requestIKDetail.status}',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: getStatusColor(requestIKDetail.status)),
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
