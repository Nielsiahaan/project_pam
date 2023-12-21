import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SuratDetailModal extends StatelessWidget {
  final int requestId;

  SuratDetailModal({required this.requestId});

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
                      'Detail Request Surat',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Kategori Surat: ${suratRequestDetail.kategoriSurat}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Keterangan: ${suratRequestDetail.content}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tanggal Pengambilan: ${DateFormat('yyyy-MM-dd HH:mm').format(suratRequestDetail.tanggalPengambilan)}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Status: ${suratRequestDetail.status}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w400),
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
