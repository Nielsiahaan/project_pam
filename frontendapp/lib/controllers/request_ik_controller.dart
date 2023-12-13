import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/requestIK_model.dart';
import 'package:frontendapp/views/requestik_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestIKController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<RequestIkModel> requestIK = RxList<RequestIkModel>();

  
  @override
  void onInit() {
    getAllRequestIK();
    super.onInit();
  }

  Future getAllRequestIK() async {
    try {
      requestIK.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}requestIK'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var requestIKList = (json.decode(response.body)['requestIk'] as List)
            .map((item) => RequestIkModel.fromJson(item))
            .toList();
        requestIK.assignAll(requestIKList);
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future createRequestIK({
    required String deskripsi,
    required DateTime tanggal_berangkat,
    required DateTime tanggal_kembali,
  }) async {
    try {
      var data = {
        'deskripsi': deskripsi,
        'tanggal_berangkat':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggal_berangkat),
        'tanggal_kembali':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggal_kembali),
      };
      var response = await http.post(
        Uri.parse('${url}requestIK'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        Get.off(() => IzinKeluarPage());
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Handle the error response
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
}
