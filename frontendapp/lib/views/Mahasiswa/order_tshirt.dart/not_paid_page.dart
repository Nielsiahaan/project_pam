import 'package:flutter/material.dart';
import 'package:frontendapp/models/order_model.dart';

class BelumBayarPage extends StatelessWidget {
  final OrderModel order;

  BelumBayarPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unpaid Order'),
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
