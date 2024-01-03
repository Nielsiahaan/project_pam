import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/booking_model.dart';
import 'package:frontendapp/models/room_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BookingRoomController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  final selectedRoomId = RxInt(1);

  RxList<BookingRoomModel> bookingRoom = RxList<BookingRoomModel>();
  RxList<RoomModel> rooms = RxList<RoomModel>();
  String getRoomNameById(int roomId) {
    RoomModel? room = rooms.firstWhere((room) => room.id == roomId);
    return room.roomName;
  }

  @override
  void onInit() {
    super.onInit();
    getAllRooms();
    getAllBooking();
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

  Future getAllBooking() async {
    try {
      bookingRoom.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}bookings'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var bookingRoomList = (json.decode(response.body)['bookings'] as List)
            .map((item) => BookingRoomModel.fromJson(item))
            .toList();
        bookingRoom.assignAll(bookingRoomList);
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future createBookingRoom({
    required int roomId,
    required DateTime startTime,
    required DateTime endTime,
    required String keterangan,
  }) async {
    try {
      var data = {
        'room_id': roomId.toString(),
        'start_time': DateFormat('yyyy-MM-dd HH:mm:ss').format(startTime),
        'end_time': DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime),
        'keterangan': keterangan,
      };

      var response = await http.post(Uri.parse('${url}booking/store/$roomId'),
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
        await getAllBooking();
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

  Future<void> cancelBooking(int roomId) async {
    try {
      var booking =
          bookingRoom.firstWhere((booking) => booking.roomId == roomId);

      if (booking.status.toLowerCase() == 'pending') {
        var response = await http.put(
          Uri.parse('${url}booking/cancel/${booking.id}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          },
        );

        if (response.statusCode == 200) {
          Get.back();
          Get.snackbar(
            'Success',
            'Booking for Room ID: $roomId cancelled successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Refresh the booking list after cancellation
          await getAllBooking();
        } else {
          Get.back();
          Get.snackbar(
            'Error',
            'Failed to cancel booking. Please try again.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[800],
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Booking with status ${booking.status} cannot be cancelled.',
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
