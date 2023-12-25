import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/tshirt_controller.dart';
import 'package:frontendapp/views/Admin/tshirt/create_tshirt.dart';
import 'package:get/get.dart';

class EditTshirtForm extends StatefulWidget {
  final int tshirtId;

  const EditTshirtForm({Key? key, required this.tshirtId}) : super(key: key);

  @override
  _EditTshirtFormState createState() => _EditTshirtFormState();
}

class _EditTshirtFormState extends State<EditTshirtForm> {
  final TshirtController _tshirtController = Get.find<TshirtController>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TshirtSize? _selectedSize;
  @override
  void initState() {
    super.initState();
    _fetchTshirtDetails();
  }

  void _fetchTshirtDetails() async {
    try {
      // Fetch details of the selected T-shirt using the provided tshirtId
      await _tshirtController.getTshirtDetails(widget.tshirtId);

      // Set the controller values to the values of the selected T-shirt
      _priceController.text =
          _tshirtController.selectedTshirt.value.price.toString();
      _quantityController.text =
          _tshirtController.selectedTshirt.value.quantity.toString();
      _selectedSize =
          stringToTshirtSize(_tshirtController.selectedTshirt.value.size);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  TshirtSize stringToTshirtSize(String sizeString) {
    return TshirtSize.values
        .firstWhere((e) => e.toString().split('.').last == sizeString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit T-shirt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(() {
            if (_tshirtController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<TshirtSize>(
                    value: _selectedSize,
                    onChanged: (TshirtSize? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSize = newValue;
                        });
                      }
                    },
                    items: TshirtSize.values
                        .map((size) => DropdownMenuItem<TshirtSize>(
                              value: size,
                              child: Text(size.toString().split('.').last),
                            ))
                        .toList(),
                    decoration: InputDecoration(labelText: 'Size'),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select the size';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the quantity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateTshirt();
                      }
                    },
                    child: Text('Update T-shirt'),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  void _updateTshirt() async {
    try {
      var priceText = _priceController.text.trim();
      var price = double.tryParse(priceText);

      // Check if quantity is a valid integer
      var quantityText = _quantityController.text.trim();
      if (!RegExp(r'^[0-9]+$').hasMatch(quantityText)) {
       
        print('Invalid quantity format');
        return;
      }

      var quantity = int.parse(quantityText);

      var result = await _tshirtController.updateTshirt(
        id: widget.tshirtId,
        size: _selectedSize!.toString().split('.').last,
        price: price!,
        quantity: quantity,
      );

      if (result != null) {
        Get.snackbar(
          'Success',
          'T-shirt updated successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.back();
      } else {
        Get.back();
        Get.snackbar(
          'Error',
          'Failed to update T-shirt',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[800],
          colorText: Colors.white,
        );
        await _tshirtController.getAllTshirt();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}