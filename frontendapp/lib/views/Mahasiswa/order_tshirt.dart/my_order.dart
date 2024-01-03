import 'package:flutter/material.dart';
import 'package:frontendapp/models/order_item_model.dart';
import 'package:frontendapp/models/order_model.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/not_paid_page.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/paid_page.dart';
import 'package:get/get.dart';
import 'package:frontendapp/controllers/order_controller.dart';

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
        title: Text('My Orders'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOrderList(context, 'Belum Bayar', false),
            buildOrderList(context, 'Sudah bayar', true),
          ],
        ),
      ),
    );
  }

  Widget buildOrderList(BuildContext context, String title, bool isPaid) {
    List<OrderModel> filteredOrders = orderController.orders
        .where((order) => isOrderPaid(order, isPaid))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (filteredOrders.isEmpty)
          ListTile(
            title: Text('No $title'),
          )
        else
          Column(
            children: filteredOrders.map((order) {
              return ListTile(
                title: Text('Order ID: ${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price: ${order.totalPrice}'),
                    // Display selected size for each order item
                    for (OrderItemModel orderItem in order.orderItemModel)
                      Text('Selected Size: ${orderItem.selectedSize}'),
                  ],
                ),
                onTap: () {
                  if (isPaid) {
                    Get.to(() => SudahBayarPage(order: order));
                  } else {
                    Get.to(() => BelumBayarPage(order: order));
                  }
                },
              );
            }).toList(),
          ),
        const Divider(),
      ],
    );
  }

  bool isOrderPaid(OrderModel order, bool isPaid) {
    return order.orderItemModel.any((item) => item.status == 'Belum bayar') ==
        !isPaid;
  }
}
