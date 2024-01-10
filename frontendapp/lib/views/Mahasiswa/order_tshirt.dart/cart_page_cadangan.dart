import 'package:flutter/material.dart';
import 'package:frontendapp/models/cart_item_model.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/checkout_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final List<TshirtModel> cartItems;
  final List<CartItemModel> cartItemsInCart;
  CartPage({required this.cartItems, required this.cartItemsInCart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late OrderController orderController;
  bool selectAll = false;
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();
    orderController = Get.find<OrderController>();

    // Initialize quantities inside initState after orderController is initialized
    quantities = List<int>.filled(orderController.cart.length, 1);

    // Check if the lengths match, if not, update selectedItems
    if (orderController.selectedItems.length != orderController.cart.length) {
      orderController.selectedItems
          .addAll(List<bool>.filled(orderController.cart.length, false));
      quantities.addAll(List<int>.filled(orderController.cart.length, 1));
    }

    // Load cart data
    _loadCartData();
  }

  // Function to load cart data
  Future<void> _loadCartData() async {
    await orderController.getCart();
    setState(() {
      // Update quantities when cart data is loaded
      quantities = List<int>.filled(orderController.cart.length, 1);
    });
  }

  // void updateQuantity(int index, bool isIncrement) {
  //   setState(() {
  //     if (isIncrement) {
  //       quantities[index]++;
  //     } else {
  //       if (quantities[index] > 1) {
  //         quantities[index]--;
  //       }
  //     }
  //     orderController.cart[index].quantity = quantities[index];
  //     orderController.calculateTotalPrice();
  //   });
  // }
  void updateQuantity(int index, bool isIncrement) {
    setState(() {
      if (index >= 0 && index < quantities.length) {
        if (isIncrement) {
          quantities[index]++;
        } else {
          if (quantities[index] > 1) {
            quantities[index]--;
          }
        }
        orderController.cart[index].quantity = quantities[index];
        orderController.calculateTotalPrice();
      } else {
        // Handle the case where the index is out of bounds
        debugPrint("Invalid index: $index");
        debugPrint("Quantities length: ${quantities.length}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart T-shirt'),
      ),
      body: Obx(
        () {
          // Loading indicator
          if (orderController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          // Cart is empty
          else if (orderController.cart.isEmpty) {
            return const Center(
              child: Text(
                'Ups, keranjangmu masih kosong nih',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          // Cart is not empty
          else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: orderController.cart.length,
                    itemBuilder: (context, index) {
                      CartItemModel cartItem = orderController.cart[index];
                      TshirtModel tshirt = cartItem.tshirt;
                      final formattedPrice = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp.',
                        decimalDigits: 0,
                      ).format(double.parse(tshirt.price));

                      return Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        confirmDismiss: (direction) async {
                          // Show a confirmation dialog if the user tries to swipe to delete
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Remove from Cart'),
                                content: const Text(
                                  'Do you really want to remove this item from the cart?',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Remove'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) {
                          // Remove the item from the cart when the user confirms
                          orderController.removeFromCart(
                            cartItem.tshirt.id,
                            cartItem.size,
                            cartItem.quantity,
                          );
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: Checkbox(
                              value: orderController.selectedItems[index],
                              onChanged: (value) {
                                setState(() {
                                  orderController.selectedItems[index] = value!;
                                });
                              },
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size: ${tshirt.size}',
                                  style: const TextStyle(
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
                                Text(
                                  'Quantity in Cart: ${cartItem.quantity}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    updateQuantity(index, false);
                                  },
                                ),
                                Text(
                                  '${cartItem.quantity}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    updateQuantity(index, true);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: const Border(
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
                            for (int i = 0;
                                i < orderController.selectedItems.length;
                                i++) {
                              orderController.selectedItems[i] = value;
                            }
                          });
                        },
                      ),
                      const Text('Select All'),
                      const Spacer(),
                      Text(
                        'Total: Rp ${orderController.calculateTotalPrice().toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          List<TshirtModel> selectedTshirts = [];
                          List<int> selectedQuantities = [];
                          for (int i = 0;
                              i < orderController.cart.length;
                              i++) {
                            if (orderController.selectedItems[i]) {
                              selectedTshirts
                                  .add(orderController.cart[i].tshirt);
                              selectedQuantities.add(quantities[i]);
                            }
                          }
                          await Get.to(() => CheckoutPage(
                                selectedTshirts: selectedTshirts,
                                selectedQuantities: selectedQuantities,
                              ));
                        },
                        child: const Text('Check Out'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
