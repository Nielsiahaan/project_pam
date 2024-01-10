// import 'package:flutter/material.dart';
// import 'package:frontendapp/controllers/tshirt_controller.dart';
// import 'package:get/get.dart';

// enum TshirtSize { S, M, L, XL, XXL }

// class CreateTshirtForm extends StatefulWidget {
//   @override
//   _CreateTshirtFormState createState() => _CreateTshirtFormState();
// }

// class _CreateTshirtFormState extends State<CreateTshirtForm> {
//   final TshirtController _tshirtController = Get.find<TshirtController>();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _quantityController = TextEditingController();

//   TshirtSize _selectedSize = TshirtSize.S;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create T-shirt', style: TextStyle(color: Colors.white),),
//         backgroundColor: Colors.teal[400],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               DropdownButtonFormField<TshirtSize>(
//                 value: _selectedSize,
//                 onChanged: (TshirtSize? newValue) {
//                   if (newValue != null) {
//                     setState(() {
//                       _selectedSize = newValue;
//                     });
//                   }
//                 },
//                 items: TshirtSize.values
//                     .map((size) => DropdownMenuItem<TshirtSize>(
//                           value: size,
//                           child: Text(
//                             size.toString().split('.').last,
//                             style: TextStyle(
//                               color: Colors.teal,
//                             ),
//                           ),
//                         ))
//                     .toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Size',
//                   labelStyle: TextStyle(
//                     color: Colors.teal,
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select the size';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _priceController,
//                 decoration: InputDecoration(
//                   labelText: 'Price',
//                   labelStyle: TextStyle(
//                     color: Colors.teal,
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the price';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _quantityController,
//                 decoration: InputDecoration(
//                   labelText: 'Quantity',
//                   labelStyle: TextStyle(
//                     color: Colors.teal[400],
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the quantity';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _addTshirt();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.teal[400],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Text(
//                     'Add T-shirt',
//                     style: TextStyle(
//                       fontSize: 18,color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _addTshirt() async {
//     try {
//       var priceText = _priceController.text.trim();

//       if (priceText.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Please enter the price'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       var price = double.tryParse(priceText);

//       if (price == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Invalid price format'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         return;
//       }

//       var result = await _tshirtController.createTshirt(
//         size: _selectedSize.toString().split('.').last,
//         price: price,
//         quantity: int.parse(_quantityController.text),
//       );

//       // Reset the form and controllers regardless of the result
//       _formKey.currentState!.reset();
//       _priceController.clear();
//       _quantityController.clear();

//       if (result != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('T-shirt added successfully'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to add T-shirt'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/tshirt_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum TshirtSize { S, M, L, XL, XXL }

class CreateTshirtForm extends StatefulWidget {
  @override
  _CreateTshirtFormState createState() => _CreateTshirtFormState();
}

class _CreateTshirtFormState extends State<CreateTshirtForm> {
  final TshirtController _tshirtController = Get.find<TshirtController>();
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();

  TshirtSize _selectedSize = TshirtSize.S;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create T-shirt',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: Text(
                            size.toString().split('.').last,
                            style: const TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Size',
                  labelStyle: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select the size';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 16, color: Colors.teal[300]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 16, color: Colors.teal[300]),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(
                    color: Colors.teal[400],
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
                style: TextStyle(fontSize: 16, color: Colors.teal[300]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addTshirt();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.all(18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Add T-shirt',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addTshirt() async {
    try {
      var priceText = _priceController.text.trim();

      if (priceText.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter the price'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      var price = double.tryParse(priceText);

      if (price == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid price format'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

       await _tshirtController.createTshirt(
        size: _selectedSize.toString().split('.').last,
        price: price,
        quantity: int.parse(_quantityController.text),
      );

      // Reset the form and controllers regardless of the result
      // _formKey.currentState.reset();
      _priceController.clear();
      _quantityController.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
