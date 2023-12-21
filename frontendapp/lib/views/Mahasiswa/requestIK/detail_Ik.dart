import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IzinKeluarDetailModal extends StatelessWidget {
  final int requestId;

  IzinKeluarDetailModal({required this.requestId});

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
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detail Izin Keluar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Alasan: ${requestIKDetail.deskripsi}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                        'Tanggal berangkat: ${DateFormat('yyyy-MM-dd HH:mm').format(requestIKDetail.tanggalBerangkat)}'),
                    SizedBox(height: 8.0),
                    Text(
                        'Tanggal kembali: ${DateFormat('yyyy-MM-dd HH:mm').format(requestIKDetail.tanggalKembali)}'),
                    SizedBox(height: 8.0),
                    Text(
                      'Status: ${requestIKDetail.status}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Close'),
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
