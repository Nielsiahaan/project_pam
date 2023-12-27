import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/requestIB_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RequestIBController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<RequestIbModel> requestIB = RxList<RequestIbModel>();

  @override
  void onInit() {
    getAllRequestIB();
    super.onInit();
  }

  Future getAllRequestIB() async {
    try {
      requestIB.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}requestIB'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var requestIBList = (json.decode(response.body)['requestIB'] as List)
            .map((item) => RequestIbModel.fromJson(item))
            .toList();
        requestIB.assignAll(requestIBList);
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future createRequestIB(
      {required String deskripsi,
      required DateTime tanggal_berangkat,
      required DateTime tanggal_kembali,
      required String tujuan}) async {
    try {
      var data = {
        'deskripsi': deskripsi,
        'tanggal_berangkat':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggal_berangkat),
        'tanggal_kembali':
            DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggal_kembali),
        'tujuan': tujuan,
      };

      var response = await http.post(Uri.parse('${url}requestIB'),
          headers: {
            'Accept': 'Application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await getAllRequestIB();
      } else {
        Get.snackbar('Error', json.decode(response.body)['error'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future cancelRequestIB(int requestId) async {
    try {
      var izinBermalam =
          requestIB.firstWhere((requestIb) => requestIb.id == requestId);
      if (izinBermalam.status.toLowerCase() == 'pending') {
        var response = await http.put(
          Uri.parse('${url}requestIB/cancel/$requestId'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
        );

        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar('Success', json.decode(response.body)['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);
          await getAllRequestIB();
        } else {
          Get.back();
          Get.snackbar('Error', json.decode(response.body)['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red[800],
              colorText: Colors.white);
              await getAllRequestIB();
        }
      } else {
        Get.snackbar(
          'Error',
          'Izin Bermalam with status ${izinBermalam.status} cannot be cancelled.',
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
