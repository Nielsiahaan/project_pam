import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/views/Admin/tshirt/index_tshirt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TshirtController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<TshirtModel> tshirts = RxList<TshirtModel>();
  Rx<TshirtModel> selectedTshirt = TshirtModel(
    id: 0,
    size: '',
    price: 0.0,
    quantity: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    getAllTshirt();
    super.onInit();
  }

  Future getAllTshirt() async {
    try {
      var response = await http.get(Uri.parse('${url}tshirt'), headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${box.read('token')}",
      });

      if (response.statusCode == 200) {
        var tshirtList = (json.decode(response.body)['data'] as List)
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

  Future createTshirt({
    required String size,
    required double price,
    required int quantity,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        "size": size,
        "price": price.toString(),
        "quantity": quantity.toString(),
      };

      var response = await http.post(
        Uri.parse('${url}tshirt'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        Get.off(() => IndexTshirt());
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await getAllTshirt();
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }

  // Future updateTshirt({
  //   required id,
  //   required TshirtSize size,
  //   required double price,
  //   required int quantity,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     var data = {
  //       "size": size.toString().split('.').last,
  //       "price": price.toString(),
  //       "quantity": quantity.toString(),
  //     };
  //     var response = await http.put(
  //       Uri.parse('${url}tshirt/$id'),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': "Bearer ${box.read('token')}",
  //       },
  //       body: data,
  //     );

  //     if (response.statusCode == 200) {
  //       var updatedTshirt =
  //           TshirtModel.fromJson(json.decode(response.body)['data']);
  //       var index =
  //           tshirts.indexWhere((tshirt) => tshirt.id == updatedTshirt.id);
  //       if (index != -1) {
  //         tshirts[index] = updatedTshirt;
  //       }

  //       isLoading.value = false;
  //       selectedTshirt.value = updatedTshirt;
  //       Get.back();
  //       // Get.snackbar(
  //       //   'Success',
  //       //   json.decode(response.body)['message'],
  //       //   snackPosition: SnackPosition.TOP,
  //       //   backgroundColor: Colors.green,
  //       //   colorText: Colors.white,
  //       // );
  //       await getAllTshirt();
  //     } else {
  //       isLoading.value = false;
  //       Get.back();
  //       debugPrint(json.decode(response.body));
  //       await getAllTshirt();
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     debugPrint(e.toString());
  //   }
  // }

   Future<TshirtModel?> updateTshirt({
    required int id,
    required String size,
    required double price,
    required int quantity,
  }) async {
    try {
      isLoading.value = true;

      var data = {
        "size": size,
        "price": price.toString(),
        "quantity": quantity.toString(),
      };

      var response = await http.put(
        Uri.parse('${url}tshirt/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer ${box.read('token')}",
        },
        body: data,
      );

      if (response.statusCode == 200) {
        var updatedTshirt = TshirtModel.fromJson(json.decode(response.body)['data']);

        // Assuming you have a list of tshirts and a selectedTshirt variable
        var index = tshirts.indexWhere((tshirt) => tshirt.id == updatedTshirt.id);
        if (index != -1) {
          tshirts[index] = updatedTshirt;
        }

        isLoading.value = false;
        selectedTshirt.value = updatedTshirt;
        Get.back();
        await getAllTshirt();

        return updatedTshirt;
      } else {
        isLoading.value = false;
        Get.back();
        debugPrint(json.decode(response.body));
        await getAllTshirt();
        return null;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      return null;
    }
  }
  // Future updateTshirt({
  //   required int id,
  //   required TshirtSize size,
  //   required double price,
  //   required int quantity,
  // }) async {
  //   try {
  //     isLoading.value = true;

  //     var data = {
  //       "size": size.toString().split('.').last,
  //       "price": price,
  //       "quantity": quantity,
  //     };

  //     var response = await http.put(
  //       Uri.parse('${url}tshirt/$id'),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': "Bearer ${box.read('token')}",
  //         'Content-Type': 'application/json', // Set content type to JSON
  //       },
  //       body: jsonEncode(data), // Encode the data as JSON
  //     );

  //     if (response.statusCode == 200) {
  //       var updatedTshirt =
  //           TshirtModel.fromJson(json.decode(response.body)['data']);
  //       var index =
  //           tshirts.indexWhere((tshirt) => tshirt.id == updatedTshirt.id);

  //       if (index != -1) {
  //         tshirts[index] = updatedTshirt;
  //       }

  //       isLoading.value = false;
  //       selectedTshirt.value = updatedTshirt;
  //       Get.back();
  //       Get.snackbar(
  //         'Success',
  //         json.decode(response.body)['message'],
  //         snackPosition: SnackPosition.TOP,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //       );
  //       await getAllTshirt();
  //     } else {
  //       isLoading.value = false;
  //       Get.back();
  //       debugPrint(json.decode(response.body));
  //       // Handle error
  //       await getAllTshirt();
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     debugPrint(e.toString());
  //   }
  // }

  Future deleteTshirt({required int id}) async {
    try {
      isLoading.value = true;

      var response = await http.delete(Uri.parse('${url}tshirt/$id'), headers: {
        'Accept': 'application/json',
        'Authorization': "Bearer ${box.read('token')}",
      });

      if (response.statusCode == 200) {
        tshirts.removeWhere((tshirt) => tshirt.id == id);
        isLoading.value = false;
        Get.snackbar(
          'Success',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
      return false;
    }
  }

  Future getTshirtDetails(int id) async {
    try {
      var response = await http.get(
        Uri.parse('${url}tshirt/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        selectedTshirt.value =
            TshirtModel.fromJson(json.decode(response.body)['data']);
      } else {
        throw Exception('Failed to get T-shirt details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
