import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/tshirt_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTshirtForm extends StatefulWidget {
  final int tshirtId;

  const EditTshirtForm({Key? key, required this.tshirtId}) : super(key: key);

  @override
  _EditTshirtFormState createState() => _EditTshirtFormState();
}

class _EditTshirtFormState extends State<EditTshirtForm> {
  final TshirtController _tshirtController = Get.find<TshirtController>();
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  String? _selectedSize = 'S';

  @override
  void initState() {
    super.initState();
    _fetchTshirtDetails();
  }

  void _fetchTshirtDetails() async {
    try {
      await _tshirtController.getTshirtDetails(widget.tshirtId);

      _priceController.text =
          _tshirtController.selectedTshirt.value.price.toString();
      _quantityController.text =
          _tshirtController.selectedTshirt.value.quantity.toString();
      _selectedSize = _tshirtController.selectedTshirt.value.size;

      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit T-shirt',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo[600],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(() {
            if (_tshirtController.isLoading.value) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              child: Text(
                                size,
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 16,
                                ),
                              ),
                            ))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Size',
                      labelStyle: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                    ),
                    validator: (value) {
                      if (_selectedSize == null) {
                        return 'Please select the size';
                      }
                      return null;
                    },
                    onTap: () {
                      if (_selectedSize != null) {
                        setState(() {
                          _selectedSize = _selectedSize;
                        });
                      }
                    },
                    disabledHint: Text(
                      'Size: $_selectedSize',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      labelStyle: const TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 16, color: Colors.teal[400]),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price';
                      }
                      return null;
                    },
                    
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _quantityController,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: TextStyle(
                        color: Colors.teal[400],
                        fontSize: 16,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal[400]!),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 16, color: Colors.teal[400]),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the quantity';
                      }
                      return null;
                    },
                    
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _updateTshirt();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Update T-shirt',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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

      var quantityText = _quantityController.text.trim();
      if (!RegExp(r'^[0-9]+$').hasMatch(quantityText)) {
        debugPrint('Invalid quantity format');
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
