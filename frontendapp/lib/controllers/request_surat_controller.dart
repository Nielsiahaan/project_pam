import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/suratRequest_model.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestSuratController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<RequestSuratModel> requestSurat = RxList<RequestSuratModel>();
  @override
  void onInit() {
    getAllSuratRequest();
    super.onInit();
  }

  Future getAllSuratRequest() async {
    try {
      requestSurat.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}surat'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var requestSuratList = (json.decode(response.body)['data'] as List)
            .map((item) => RequestSuratModel.fromJson(item))
            .toList();
        requestSurat.assignAll(requestSuratList);
      } else {
        isLoading.value = false;
        debugPrint('Error in API response: ${json.decode(response.body)}');
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error in getAllSuratRequest: $e');
    }
  }

  Future storeSuratRequest({
    required String kategori_surat,
    required String content,
    required DateTime tanggal_pengambilan,
  }) async {
    try {
      var data = {
        'kategori_surat': kategori_surat,
        'content': content,
        'tanggal_pengambilan':
            DateFormat('yyyy-MM-dd').format(tanggal_pengambilan),
      };

      var response = await http.post(
        Uri.parse('${url}surat'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        },
        body: data,
      );

      if (response.statusCode == 201) {
        Get.off(() => SuratRequestPage());
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Refresh the list of surat requests after successful creation
       await getAllSuratRequest();
      } else {
        //Handle the error response
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

  Future cancelSurat(int requestId) async {
    try {
      var suratRequest =
          requestSurat.firstWhere((surat) => surat.id == requestId);
      if (suratRequest.status.toLowerCase() == 'pending') {
        var response = await http
            .put(Uri.parse('${url}surat/cancel/$requestId'), headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}'
        });

        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar('Success', json.decode(response.body)['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          await getAllSuratRequest();
        } else {
          Get.back();
          Get.snackbar('Error', json.decode(response.body)['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red[800],
              colorText: Colors.white);
        }
      } else {
        Get.snackbar(
          'Error',
          'Request Surat with status ${suratRequest.status} cannot be cancelled.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
