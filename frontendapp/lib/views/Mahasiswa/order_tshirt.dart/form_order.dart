import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/order_controller.dart';
import 'package:frontendapp/models/tshirt_model.dart';
import 'package:frontendapp/views/Mahasiswa/order_tshirt.dart/checkout_page.dart';
import 'package:get/get.dart';

class OrderFormPage extends StatefulWidget {
  final TshirtModel tshirt;

  const OrderFormPage({super.key, required this.tshirt});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final OrderController orderController = Get.put(OrderController());
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod.CreditCard,
    PaymentMethod.CashOnDelivery,
    PaymentMethod.BankTransfer,
    PaymentMethod.DebitCard,
  ];
  PaymentMethod selectedPaymentMethod = PaymentMethod.CreditCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Order Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size: ${widget.tshirt.size}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Price: Rp.${widget.tshirt.price}'),
            const SizedBox(height: 8),
            Text('Stock: ${widget.tshirt.quantity}'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Jumlah T-shirt: '),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    orderController.decrementQuantity();
                  },
                ),
                Obx(() {
                  final orderController = Get.find<OrderController>();
                  return Text(
                    '${orderController.quantity.value}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  );
                }),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    orderController.incrementQuantity();
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Text('Total Harga: Rp ${calculateTotalPrice()}'),
            SizedBox(height: 16),
            buildPaymentDropdown(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                orderController.placeOrderAndMakePayment(
                    widget.tshirt.id,
                    widget.tshirt.size,
                    widget.tshirt.quantity,
                    selectedPaymentMethod);
              },
              child: Text('Place Order'),
            ),
          ],
        ),
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
    final orderController = Get.find<OrderController>();
    double shirtPrice = double.tryParse(widget.tshirt.price) ?? 0.0;
    double totalPrice = shirtPrice * orderController.quantity.value;
    return totalPrice;
  }
}
