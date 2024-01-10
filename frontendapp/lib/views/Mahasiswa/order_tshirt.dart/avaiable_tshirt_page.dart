import 'package:flutter/material.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/cart_page.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/detail_tshirt.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/my_order.dart';
import 'package:get/get.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/models/tshirt_model.dart';

class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final OrderController orderController = Get.put(OrderController());
  List<TshirtModel> cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text(
            'Order T-shirt',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.deepOrangeAccent,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Modify the CartPage instantiation to include both T-shirt items and CartItem items
                Get.to(() => CartPage(
                    cartItems: orderController.tshirts,
                    cartItemsInCart: orderController.cart));
              },
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => MyOrderPage());
                },
                icon: const Icon(Icons.assignment_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<TshirtModel>>(
            future: orderController.getAllTshirt(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(
                  child: Text('Error loading data'),
                );
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('T-shirt not available right now'),
                );
              } else {
                orderController.tshirts.assignAll(snapshot.data!);

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Available T-Shirts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return buildSizeContainer(
                            context,
                            snapshot.data![index],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  Widget buildSizeContainer(BuildContext context, TshirtModel tshirt) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.deepOrangeAccent,
              Colors.orangeAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size: ${tshirt.size}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock: ${tshirt.quantity}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Get.bottomSheet(
                  TshirtDetail(tshirt: tshirt),
                  isScrollControlled: true,
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.deepOrangeAccent,
                backgroundColor: Colors.white,
              ),
              child: const Text('See Details'),
            ),
          ],
        ),
      ),
    );
  }
}
