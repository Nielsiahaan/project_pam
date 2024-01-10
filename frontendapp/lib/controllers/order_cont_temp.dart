import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontendapp/constants/constants.dart';
import 'package:frontendapp/models/cart_item_model.dart';
import 'package:frontendapp/models/order_item_model.dart';
import 'package:frontendapp/models/order_model.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/cart_page.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/checkout_page.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/my_order.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  final isLoading = false.obs;
  final box = GetStorage();
  List<bool> selectedItems = [];
  RxDouble totalPrice = 0.0.obs;
  List<CartItemModel> get cartItems => cart;
  RxList<OrderModel> orders = RxList<OrderModel>();
  RxList<OrderItemModel> orderItems = RxList<OrderItemModel>();
  RxList<TshirtModel> tshirts = RxList<TshirtModel>();
  RxList<CartItemModel> cart = <CartItemModel>[].obs;
  RxInt quantity = 1.obs;
  List<TshirtModel> cartItem = [];
  RxList<int> quantities = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllTshirt();
    fetchOrders();
    getCart();
    selectedItems.addAll(List<bool>.filled(cart.length, false));
    calculateTotalPrice();
  }

  Future<void> addToCart(int tshirtId, String size, int quantity) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('${url}add-to-cart/$tshirtId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'size': size,
          'quantity': quantity.toString(),
        },
      );

      if (response.statusCode == 201) {
        // Successful response from the server
        isLoading.value = false;
        Get.to(() => CartPage(cartItems: tshirts, cartItemsInCart: cart));
        await getCart();
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  // Future getCart() async {
  //   try {
  //     isLoading.value = true;

  //     var response = await http.get(
  //       Uri.parse('${url}get-cart'),
  //       headers: {
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${box.read('token')}',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Successful response from the server, update the local cart
  //       var cartItemList = (json.decode(response.body)['data'] as List)
  //           .map((item) => CartItemModel.fromJson(item))
  //           .toList();
  //       cart.assignAll(cartItemList);
  //       isLoading.value = false;
  //       update();
  //     } else {
  //       isLoading.value = false;
  //       // Get.snackbar(
  //       //   'Error',
  //       //   'Failed to retrieve cart items',
  //       //   snackPosition: SnackPosition.TOP,
  //       //   backgroundColor: Colors.red[800],
  //       //   colorText: Colors.white,
  //       // );
  //       debugPrint(json.decode(response.body).toString());
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     isLoading.value = false;
  //     debugPrint(e.toString());
  //   }
  // }
  Future getCart() async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('${url}get-cart'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        // Successful response from the server, update the local cart
        var cartItemList = (json.decode(response.body)['data'] as List)
            .map((item) => CartItemModel.fromJson(item))
            .toList();
        cart.assignAll(cartItemList);
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> removeFromCart(int tshirtId, String size, int quantity) async {
    try {
      isLoading.value = true;

      // Make an API call to remove the T-shirt from the cart
      var response = await http.post(
        Uri.parse('${url}remove-from-cart/$tshirtId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'size': size,
          'quantity': quantity.toString(),
        },
      );

      if (response.statusCode == 200) {
        quantities.assignAll(cart.map((item) => item.quantity));
        isLoading.value = false;
        await getCart();
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
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
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  // Increment and decrement methods
  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void incrementQuantity() {
    quantity++;
  }

  Future<void> placeOrderAndMakePayment(int tshirtId, String selectedSize,
      int quantity, PaymentMethod paymentMethod) async {
    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('${url}place-order-and-make-payment/$tshirtId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: {
          'selected_size': selectedSize,
          'quantity': quantity.toString(),
          'payment_method': _paymentMethodToString(paymentMethod),
        },
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        Get.to(() => MyOrderPage());
        _showSuccessSnackbar(response);
        await fetchOrders();
      } else {
        isLoading.value = false;
        _showErrorSnackbar(response);
      }
    } catch (e) {
      isLoading.value = false;
      _handleError(e);
    }
  }

  void _showSuccessSnackbar(http.Response response) {
    Get.snackbar(
      'Success',
      json.decode(response.body)['message'],
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    //  debugPrint(json.decode(response.body).toString());
  }

  void _showErrorSnackbar(http.Response response) {
    Get.snackbar(
      'Error',
      json.decode(response.body)['message'],
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
    );
    debugPrint(json.decode(response.body).toString());
  }

  void _handleError(dynamic error) {
    if (error is SocketException) {
      Get.snackbar(
        'Error',
        'Network error. Please check your internet connection.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
    } else if (error is FormatException) {
      Get.snackbar(
        'Error',
        'Failed to decode the server response.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[800],
        colorText: Colors.white,
      );
    }
  }

  String _paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.CreditCard:
        return 'CreditCard';
      case PaymentMethod.CashOnDelivery:
        return 'CashOnDelivery';
      case PaymentMethod.BankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.DebitCard:
        return 'DebitCard';
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
        _showSuccessSnackbar(response);
        await fetchOrders();
      } else {
        isLoading.value = false;
        _showErrorSnackbar(response);
      }
    } catch (e) {
      isLoading.value = false;
      _handleError(e);
    }
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
        debugPrint(json.decode(response.body).toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // double calculateTotalPrice() {
  //   double total = 0.0;
  //   for (int i = 0; i < cart.length; i++) {
  //     double itemPrice = double.parse(cart[i].tshirt.price);
  //     int itemQuantity = cart[i].quantity;
  //     if (selectedItems[i]) {
  //       total += itemPrice * itemQuantity;
  //     }
  //   }
  //   totalPrice.value = total;
  //   return total;
  // }

  // double calculateTotalPrice() {
  //   double total = 0.0;

  //   // Check if the lengths match, if not, update selectedItems
  //   if (selectedItems.length != cart.length) {
  //     selectedItems.addAll(List<bool>.filled(cart.length, false));
  //   }

  //   for (int i = 0; i < cart.length; i++) {
  //     double itemPrice = double.parse(cart[i].tshirt.price);
  //     int itemQuantity = cart[i].quantity;

  //     // Check if the index is within the bounds of selectedItems
  //     if (i < selectedItems.length && selectedItems[i]) {
  //       total += itemPrice * itemQuantity;
  //     }
  //   }

  //   totalPrice.value = total;
  //   return total;
  // }
  double calculateTotalPrice() {
    double total = 0.0;

    // Ensure that selectedItems and cart have the same length
    if (selectedItems.length != cart.length) {
      selectedItems = List<bool>.filled(cart.length, false);
    }

    for (int i = 0; i < cart.length; i++) {
      double itemPrice = double.tryParse(cart[i].tshirt.price) ?? 0.0;
      int itemQuantity = cart[i].quantity;

      // Check if the index is within the bounds of selectedItems
      if (i < selectedItems.length && selectedItems[i]) {
        total += itemPrice * itemQuantity;
      }
    }

    // Round the total to two decimal places
    total = double.parse(total.toStringAsFixed(2));

    totalPrice.value = total;
    return total;
  }
}
