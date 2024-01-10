// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:frontendapp/controllers/request_ik_controller.dart';

// Future<void> submitFormIK(
//   DateTime berangkat,
//   DateTime kembali,
//   TextEditingController keperluanController,
//   RequestIKController requestIKController,
// ) async {
//   DateTime currentDate = DateTime.now();

//   // Validate if the selected dates are not before the current date
//   if (berangkat.isBefore(currentDate) || kembali.isBefore(currentDate)) {
//     Get.snackbar(
//       'Error',
//       'Tidak dapat memilih tanggal atau waktu sebelum hari ini.',
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.red[800],
//       colorText: Colors.white,
//     );
//     return;
//   }

//   // Validate if tanggal_kembali is after tanggal_berangkat
//   if (kembali.isBefore(berangkat)) {
//     Get.snackbar(
//       'Error',
//       'Tanggal kembali harus setelah tanggal berangkat.',
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.red[800],
//       colorText: Colors.white,
//     );
//     return;
//   }

//   try {
//     await requestIKController.createRequestIK(
//       deskripsi: keperluanController.text,
//       tanggal_berangkat: berangkat,
//       tanggal_kembali: kembali,
//     );

//     keperluanController.clear();
//   } catch (e) {
//     Get.snackbar(
//       'Error',
//       'Gagal melakukan request Izin Keluar Kampus.',
//       snackPosition: SnackPosition.TOP,
//       backgroundColor: Colors.red[800],
//       colorText: Colors.white,
//     );
//     debugPrint(e.toString());
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';

Future<void> submitFormIK(
  DateTime berangkat,
  DateTime kembali,
  TextEditingController keperluanController,
  RequestIKController requestIKController,
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
    await requestIKController.createRequestIK(
      deskripsi: keperluanController.text,
      tanggal_berangkat: berangkat,
      tanggal_kembali: kembali,
    );

    keperluanController.clear();
  } catch (e) {
    Get.snackbar(
      'Error',
      'Gagal melakukan request Izin Keluar Kampus.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
    );
    debugPrint(e.toString());
  }
}
