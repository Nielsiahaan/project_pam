import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/controllers/request_surat_controller.dart';
import 'package:frontendapp/models/suratRequest_model.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final RequestSuratController _requestSuratController =
      Get.put(RequestSuratController());
  RxList<RequestSuratModel> requestSurat = RxList<RequestSuratModel>();

  Future approveSurat({required int id}) async {
    await _updateStatusSurat(id: id, status: 'approved');
  }

  Future rejectSurat({required int id}) async {
    await _updateStatusSurat(id: id, status: 'rejected');
  }

  Future _updateStatusSurat({required int id, required String status}) async {
    try {
      var response =
          await http.put(Uri.parse('${url}${status}_surat/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  

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
        // Handle kesalahan jika HTTP status code bukan 200 OK
        debugPrint('Error in API response: ${json.decode(response.body)}');
        return 'Unknown';
      }
    } catch (e) {
      // Handle kesalahan umum
      debugPrint('Error in getNamaMahasiswaFromId: $e');
      return 'Unknown';
    }
  }
}
