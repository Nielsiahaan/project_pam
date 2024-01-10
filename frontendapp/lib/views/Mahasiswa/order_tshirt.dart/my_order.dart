import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/models/order_item_model.dart';
import 'package:frontendapp/models/order_model.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Obx(
        () {
          if (orderController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (orderController.orders.isEmpty) {
            return const Center(child: Text('No orders available'));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (OrderModel orders in orderController.orders)
                    buildOrderCard(orders),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildOrderCard(OrderModel order) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Total Price: ${order.totalPrice}'),
            for (OrderItemModel orderItem in order.orderItemModel)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Selected Size: ${orderItem.selectedSize}'),
                  Text('Status: ${orderItem.status}'),
                ],
              ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
