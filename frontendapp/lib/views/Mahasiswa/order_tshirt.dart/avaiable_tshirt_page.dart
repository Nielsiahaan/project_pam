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
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartPage(cartItems: orderController.tshirts));
            },
          ),
          IconButton(
              onPressed: () {
                Get.to(() => MyOrderPage());
              },
              icon: Icon(Icons.assignment_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: orderController.getAllTshirt(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading data'),
              );
            } else if (orderController.tshirts.isEmpty) {
              return Center(
                child: Text('T-shirt not available right now'),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Available T-Shirts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: orderController.tshirts.length,
                      itemBuilder: (context, index) {
                        return buildSizeContainer(
                          context,
                          orderController.tshirts[index],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildSizeContainer(BuildContext context, TshirtModel tshirt) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Stock: ${tshirt.quantity}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
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
              child: Text('See Details'),
            ),
          ],
        ),
      ),
    );
  }
}
