import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final List<TshirtModel> selectedTshirts;
  final List<int> selectedQuantities;

  CheckoutPage({
    required this.selectedTshirts,
    required this.selectedQuantities,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

enum PaymentMethod {
  CreditCard,
  CashOnDelivery,
  BankTransfer,
  DebitCard,
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod selectedPaymentMethod = PaymentMethod.CreditCard;
  final OrderController _orderController = Get.put(OrderController());
  late List<int> quantities;
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod.CreditCard,
    PaymentMethod.CashOnDelivery,
    PaymentMethod.BankTransfer,
    PaymentMethod.DebitCard,
  ];
  @override
  void initState() {
    super.initState();
    // Menyamakan nilai quantities dengan widget.selectedQuantities
    quantities = List<int>.from(widget.selectedQuantities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedTshirts.length,
              itemBuilder: (context, index) {
                TshirtModel tshirt = widget.selectedTshirts[index];
                int quantity = quantities[
                    index]; // Menggunakan quantities dari state lokal
                final formattedPrice = NumberFormat.currency(
                  locale: 'id_ID',
                  symbol: 'Rp.',
                  decimalDigits: 0,
                ).format(double.parse(tshirt.price));

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
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
                          'Quantity: $quantity',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Method:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                buildPaymentDropdown(),
                const SizedBox(height: 16),
                Text(
                  'Total Price: Rp ${calculateTotalPrice().toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      for (var i = 0; i < widget.selectedTshirts.length; i++) {
                        TshirtModel selectedTshirt = widget.selectedTshirts[i];
                        int quantity = quantities[i];
                        await _orderController.placeOrderAndMakePayment(
                          selectedTshirt.id,
                          selectedTshirt.size,
                          quantity,
                          selectedPaymentMethod,
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'An error occurred during the payment and order process',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red[800],
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text('Order now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentDropdown() {
    return DropdownButton<PaymentMethod>(
      value: selectedPaymentMethod,
      items: paymentMethods.map((method) {
        return DropdownMenuItem<PaymentMethod>(
          value: method,
          child: Text(_paymentMethodToString(method)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedPaymentMethod = value!;
        });
      },
    );
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

  double calculateTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < widget.selectedTshirts.length; i++) {
      double itemPrice = double.parse(widget.selectedTshirts[i].price);
      int itemQuantity = widget.selectedQuantities[i];
      total += itemPrice * itemQuantity;
    }
    return total;
  }
}
