import 'package:flutter/material.dart';
import 'package:frontendapp/models/order_model.dart';

class SudahBayarPage extends StatelessWidget {
  final OrderModel order;

  SudahBayarPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan yang dikemas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Total Price: ${order.totalPrice}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
