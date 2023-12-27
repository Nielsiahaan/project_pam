import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/tshirt_controller.dart';
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
  String? _selectedSize = 'S';

  @override
  void initState() {
    super.initState();
    _fetchTshirtDetails();
  }

  void _fetchTshirtDetails() async {
    try {
      await _tshirtController.getTshirtDetails(widget.tshirtId);

      // Set the controller values to the values of the selected T-shirt
      _priceController.text =
          _tshirtController.selectedTshirt.value.price.toString();
      _quantityController.text =
          _tshirtController.selectedTshirt.value.quantity.toString();
      _selectedSize = _tshirtController.selectedTshirt.value.size;

      // Ensure to trigger a rebuild after fetching the T-shirt details
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
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
                  DropdownButtonFormField<String>(
                    key: UniqueKey(),
                    value: _selectedSize,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSize = newValue;
                        });
                      }
                    },
                    items: ['S', 'M', 'L', 'XL', 'XXL']
                        .map((size) => DropdownMenuItem<String>(
                              value: size,
                              child: Text(size),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Size',
                      // set value enable to be _selectedSize
                      enabled: _selectedSize == _selectedSize,
                    ),
                    validator: (value) {
                      if (_selectedSize == null) {
                        return 'Please select the size';
                      }
                      return null;
                    },
                    onTap: () {
                      // Set value to be _selectedSize to disable the dropdown
                      if (_selectedSize != null) {
                        setState(() {
                          _selectedSize = _selectedSize;
                        });
                      }
                    },
                    disabledHint: Text('Size: $_selectedSize'),
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

      await _tshirtController.updateTshirt(
        id: widget.tshirtId,
        size: _selectedSize!,
        price: price!,
        quantity: quantity,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
