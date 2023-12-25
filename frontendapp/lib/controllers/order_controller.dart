import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/order_model.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<OrderModel> orders = RxList<OrderModel>();
  RxList<TshirtModel> tshirts = RxList<TshirtModel>();

  // Enum getSizeTshirtById(int tshirtId){

  // }
  @override
  void onInit() {
    super.onInit();
    getAllTshirt();
    fetchOrders();
  }

  Future getAllTshirt() async {
    try {
      var response = await http.get(Uri.parse('${url}tshirt'), headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${box.read('token')}",
      });

      if (response.statusCode == 200) {
        var tshirtList = (json.decode(response.body)['tshirts'] as List)
            .map((item) => TshirtModel.fromJson(item))
            .toList();
        tshirts.assignAll(tshirtList);
      } else {
        debugPrint(json.decode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future fetchOrders() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('${url}orders-tshirt'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        var data = json.decode(response.body)['orders'] as List;
        orders.assignAll(data.map((order) => OrderModel.fromJson(order)));
      } else {
        isLoading.value = false;
        print('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> placeOrder(
      int tshirtId, String selectedSize, int quantity) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('${url}orders-place/$tshirtId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'selected_size': selectedSize,
          'quantity': quantity.toString(),
        },
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await fetchOrders();
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      isLoading.value = true;

      var response = await http.put(
        Uri.parse('${url}orders/cancel/$orderId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await fetchOrders();
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> makePayment(int orderId, String paymentMethod) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('${url}payments-make/$orderId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'payment_method': paymentMethod,
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await fetchOrders();
      } else {
        isLoading.value = false;
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
