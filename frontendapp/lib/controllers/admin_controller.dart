import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/controllers/bookingRoom_controller.dart';
import 'package:frontendapp/controllers/request_ib_controller.dart';
import 'package:frontendapp/controllers/request_ik_controller.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/models/mahasiswa_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  RxList<Mahasiswa> mahasiswa = RxList<Mahasiswa>();
  // Object Controllers
  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());
  final RequestIKController _requestIKController =
      Get.put(RequestIKController());
  final RequestIBController _requestIBController =
      Get.put(RequestIBController());
  final BookingRoomController _bookingRoomController =
      Get.put(BookingRoomController());

  // Get mahasiswa
  Future<String> getNamaMahasiswaFromId(int mahasiswaId) async {
    try {
      var response = await http.get(
        Uri.parse('${url}mahasiswa/$mahasiswaId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var namaMahasiswa = data['mahasiswa'];
        return namaMahasiswa;
      } else {
        debugPrint('Error in API response: ${json.decode(response.body)}');
        return 'Unknown';
      }
    } catch (e) {
      debugPrint('Error in getNamaMahasiswaFromId: $e');
      return 'Unknown';
    }
  }

  // Update Status Surat
  Future approveSurat({required int id}) async {
    await _updateStatusSurat(id: id, status: 'approved');
  }

  Future rejectSurat({required int id}) async {
    await _updateStatusSurat(id: id, status: 'rejected');
  }

  Future _updateStatusSurat({required int id, required String status}) async {
    try {
      var response = await http.put(
        Uri.parse('${url}${status}_surat/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await _requestSuratController.getAllSuratRequest();
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        await _requestSuratController.getAllSuratRequest();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Update Status IK

  Future approveIK({required int id}) async {
    await _updateStatusIK(id: id, status: 'approved');
  }

  Future rejectIK({required int id}) async {
    await _updateStatusIK(id: id, status: 'rejected');
  }

  Future _updateStatusIK({required int id, required String status}) async {
    try {
      var response = await http.put(Uri.parse('${url}${status}_ik/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        await _requestIKController.getAllRequestIK();
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        await _requestIKController.getAllRequestIK();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Update Status IB
  Future approveIB({required int id}) async {
    await _updateStatusIB(id: id, status: 'approved');
  }

  Future rejectIB({required int id}) async {
    await _updateStatusIB(id: id, status: 'rejected');
  }

  Future _updateStatusIB({required int id, required String status}) async {
    try {
      var response = await http.put(Uri.parse('${url}${status}_ib/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await _requestIBController.getAllRequestIB();
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        await _requestIBController.getAllRequestIB();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Update status Booking room
  Future approveBookingRoom({required int id}) async {
    await _updateStatusBookingRoom(id: id, status: 'approved');
  }

  Future rejectBookingRoom({required int id}) async {
    await _updateStatusBookingRoom(id: id, status: 'rejected');
  }

  Future _updateStatusBookingRoom(
      {required int id, required String status}) async {
    try {
      var response = await http.put(Uri.parse('${url}${status}_room/$id'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}'
          });
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await _bookingRoomController.getAllBooking();
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        await _bookingRoomController.getAllBooking();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
