import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/views/home/admin_dashboard.dart';
import 'package:frontendapp/views/home/base_page.dart';
import 'package:frontendapp/views/authentikasi/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();

  Future register({
    required String name,
    String? username,
    required String email,
    required String password,
    String? no_ktp,
    String? nim,
    String? no_telp,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'no_ktp': no_ktp,
        'nim': nim,
        'no_telp': no_telp,
      };
      var response = await http.post(
        Uri.parse(url + 'register'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);

        Get.off(() => const LoginPage());
        Get.snackbar('Success', 'Successfully Registered',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        try {
          var decodedData = json.decode(response.body);
          debugPrint(decodedData.toString());
        } catch (e) {
          debugPrint("Error decoding JSON: $e");
        }
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {'email': email, 'password': password};
      var response = await http.post(
        Uri.parse(url + 'login'),
        headers: {'Accept': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        //tulis token
        box.write('token', token.value);

        // check the role of user
        var role = json.decode(response.body)['user']['role'];

        if (role == 'admin') {
          Get.offAll(() => const AdminDashboard());
        } else if (role == 'mahasiswa') {
          Get.offAll(() => const BasePage());
        } else {
          Get.offAll(() => const LoginPage());
        }
      } else {
        isLoading.value = false;
        final snackBar = GetSnackBar(
          titleText: Text('Error', style: TextStyle(color: Colors.white)),
          messageText: Text(json.decode(response.body)['message'],
              style: TextStyle(color: Colors.white)),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          borderRadius: 10.0,
          margin: const EdgeInsets.all(10.0),
          duration: const Duration(seconds: 3),
          isDismissible: true,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          reverseAnimationCurve: Curves.fastOutSlowIn,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );

        Get.showSnackbar(snackBar);

        try {
          var decodedData = json.decode(response.body);
          debugPrint(decodedData.toString());
        } catch (e) {
          debugPrint("Error decoding JSON: $e");
        }
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      // Get the token from the storage
      String? storedToken = box.read('token');

      if (storedToken != null && storedToken.isNotEmpty) {
        var response = await http.get(Uri.parse(url + 'logout'), headers: {
          'Authorization': 'Bearer $storedToken',
          'Accept': 'application/json',
        });

        if (response.statusCode == 200) {
          isLoading.value = false;
          // clear the token
          token.value = '';
          box.remove('token');
          Get.offAll(() => const LoginPage());
          Get.snackbar('Success', 'Successfully Logged Out',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else {
          isLoading.value = false;
          Get.snackbar('Error', json.decode(response.body)['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white);
          try {
            var decodeData = json.decode(response.body);
            debugPrint(decodeData.toString());
          } catch (e) {
            debugPrint("Error decoding JSON: $e");
          }
        }
      } else {
        isLoading.value = false;
        Get.snackbar('Error', 'Token not found',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
