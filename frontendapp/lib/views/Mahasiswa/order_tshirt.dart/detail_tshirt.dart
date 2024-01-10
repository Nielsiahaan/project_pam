import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/form_order.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TshirtDetail extends StatelessWidget {
  final TshirtModel tshirt;
  final OrderController orderController = Get.put(OrderController());

  TshirtDetail({required this.tshirt});
  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp.',
      decimalDigits: 0,
    ).format(double.parse(tshirt.price));

    return Center(
      child: Wrap(children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Size: ${tshirt.size}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close_sharp),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Stock: ${tshirt.quantity}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Price: $formattedPrice',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          int tshirtId = tshirt.id;
                          String size = tshirt.size;
                          int quantity = 1;

                          // Call addToCart with the extracted details
                          await orderController.addToCart(
                              tshirtId, size, quantity);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(width: 4),
                            Text('Cart'),
                          ],
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => OrderFormPage(tshirt: tshirt));
                    },
                    child: const Text('Check Out'),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
