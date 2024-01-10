import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/room_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RoomController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();

  RxList<RoomModel> rooms = RxList<RoomModel>();
  Rx<RoomModel> selectedRoom = RoomModel(
    id: 0,
    roomName: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ).obs;

  @override
  void onInit() {
    getAllRooms();
    super.onInit();
  }

  Future getAllRooms() async {
    try {
      var response = await http.get(Uri.parse('${url}rooms'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        var roomList = (json.decode(response.body)['data'] as List)
            .map((item) => RoomModel.fromJson(item))
            .toList();
        rooms.assignAll(roomList);
      } else {
        debugPrint(json.decode(response.body));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future createRoom({required String nameRoom}) async {
    try {
      var data = {
        'roomName': nameRoom,
      };

      var response = await http.post(Uri.parse('${url}rooms'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
          body: data);

      if (response.statusCode == 201) {
        Get.back();
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await getAllRooms();
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future updateRoom({required int roomId, required String nameRoom}) async {
    try {
      var data = {
        'roomName': nameRoom,
      };

      var response = await http.put(
        Uri.parse('${url}rooms/$roomId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        var updatedRoom =
            RoomModel.fromJson(json.decode(response.body)['data']);
        var index = rooms.indexWhere((room) => room.id == updatedRoom.id);
        if (index != -1) {
          rooms[index] = updatedRoom;
        }

        // Update selectedRoom
        selectedRoom.value = updatedRoom;
        Get.back();
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await getAllRooms();
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future deleteRoom({required int roomId}) async {
    try {
      var response =
          await http.delete(Uri.parse('${url}rooms/$roomId'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        Get.snackbar('Success', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await getAllRooms();
      } else {
        Get.snackbar('Error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getRoomDetails(int roomId) async {
    try {
      var response = await http.get(Uri.parse('${url}rooms/$roomId'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        selectedRoom.value =
            RoomModel.fromJson(json.decode(response.body)['data']);
      } else {
        Get.snackbar('Error', 'Failed to fetch room details',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
