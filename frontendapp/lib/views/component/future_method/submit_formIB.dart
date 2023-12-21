// submit_form.dart
import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:get/get.dart';


Future<void> submitFormIB(
  DateTime berangkat,
  DateTime kembali,
  TextEditingController keperluanController,
  TextEditingController tujuanController,
  RequestIBController requestIKController,
) async {
  DateTime currentDate = DateTime.now();

  // Validate if the selected dates are not before the current date
  if (berangkat.isBefore(currentDate) || kembali.isBefore(currentDate)) {
    Get.snackbar(
      'Error',
      'Tidak dapat memilih tanggal atau waktu sebelum hari ini.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
    );
    return;
  }

  // Validate if tanggal_kembali is after tanggal_berangkat
  if (kembali.isBefore(berangkat)) {
    Get.snackbar(
      'Error',
      'Tanggal kembali harus setelah tanggal berangkat.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
    );
    return;
  }

  try {
    await requestIKController.createRequestIB(
      deskripsi: keperluanController.text,
      tanggal_berangkat: berangkat,
      tanggal_kembali: kembali,
      tujuan: tujuanController.text
    );

    keperluanController.clear();
  } catch (e) {
    debugPrint(e.toString());
  }
}
