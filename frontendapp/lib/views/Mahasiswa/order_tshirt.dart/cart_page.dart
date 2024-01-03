import 'package:flutter/material.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/checkout_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final List<TshirtModel> cartItems;
  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late OrderController orderController;
  List<int> quantities = [];
  List<bool> selectedItems = [];
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    orderController = Get.find<OrderController>();
    selectedItems =
        List<bool>.generate(orderController.cart.length, (index) => false);
    // Initialize the quantities list with the default quantity for each item
    quantities = List<int>.filled(orderController.cart.length, 1);
    orderController.getCart(); // Fetch cart data

    // Update: Load T-shirts from the local cart
    orderController.cart.assignAll(widget.cartItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Ensure that quantities have the same length as orderController.cart
              if (quantities.length != orderController.cart.length) {
                quantities = List<int>.filled(orderController.cart.length, 1);
              }

              return ListView.builder(
                itemCount: orderController.cart.length,
                itemBuilder: (context, index) {
                  TshirtModel tshirt = orderController.cart[index];
                  int quantity = quantities[index];
                  final formattedPrice = NumberFormat.currency(
                          locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
                      .format(double.parse(tshirt.price));
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Checkbox(
                        value: selectedItems[index],
                        onChanged: (value) {
                          setState(() {
                            selectedItems[index] = value!;
                            quantities[index] = value ? 1 : 0;
                          });
                        },
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Size: ${tshirt.size}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Price: $formattedPrice',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                // Decrement quantity
                                if (quantity > 0) {
                                  quantities[index]--;
                                }
                              });
                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                // Increment quantity
                                quantities[index]++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                top: BorderSide(color: Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (int i = 0; i < selectedItems.length; i++) {
                        selectedItems[i] = value;
                        quantities[i] = value ? 1 : 0;
                      }
                    });
                  },
                ),
                Text('Select All'),
                Spacer(),
                Text(
                  'Total: Rp ${calculateTotalPrice().toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedItems.any((selected) => selected)) {
                      List<TshirtModel> selectedTshirts = [];
                      List<int> selectedQuantities = [];

                      for (int i = 0; i < widget.cartItems.length; i++) {
                        if (selectedItems[i]) {
                          selectedTshirts.add(widget.cartItems[i]);
                          selectedQuantities.add(quantities[i]);
                        }
                      }

                      // Proceed to CheckoutPage only if there are selected items
                      await Get.to(() => CheckoutPage(
                            selectedTshirts: selectedTshirts,
                            selectedQuantities: selectedQuantities,
                          ));
                    } else {
                      // Show a message or take any other appropriate action
                      Get.snackbar(
                        'Warning',
                        'Please select items to check out',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.orange,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text('Check Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < widget.cartItems.length; i++) {
      double itemPrice = double.parse(widget.cartItems[i].price);
      int itemQuantity = quantities[i];
      if (selectedItems[i]) {
        total += itemPrice * itemQuantity;
      }
    }
    return total;
  }
}
