import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class IzinBermalamDetailModal extends StatelessWidget {
  final int requestId;

  IzinBermalamDetailModal({required this.requestId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestIBController>(
      builder: (controller) {
        var requestIBDetail = controller.requestIB
            .firstWhere((requestIB) => requestIB.id == requestId);

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
                      'Detail Izin Bermalam',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Alasan: ${requestIBDetail.deskripsi}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tujuan: ${requestIBDetail.tujuan}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                        'Tanggal berangkat: ${DateFormat('yyyy-MM-dd HH:mm').format(requestIBDetail.tanggalBerangkat)}'),
                    SizedBox(height: 8.0),
                    Text(
                        'Tanggal kembali: ${DateFormat('yyyy-MM-dd HH:mm').format(requestIBDetail.tanggalKembali)}'),
                    SizedBox(height: 8.0),
                    Text(
                      'Status: ${requestIBDetail.status}',
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
