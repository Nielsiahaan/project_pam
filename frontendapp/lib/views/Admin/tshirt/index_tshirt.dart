// import 'package:flutter/material.dart';
// import 'package:frontendapp/controllers/tshirt_controller.dart';
// import 'package:frontendapp/views/Admin/tshirt/create_tshirt.dart';
// import 'package:frontendapp/views/Admin/tshirt/edit_tshirt.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class IndexTshirt extends StatelessWidget {
//   IndexTshirt({Key? key}) : super(key: key);

//   final TshirtController _tshirtController = Get.put(TshirtController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue[600],
//         title: const Text(
//           'T-shirt List',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Get.to(() => CreateTshirtForm());
//               },
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 child: const Center(
//                   child: Text(
//                     'Add T-shirt',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue[600],
//               ),
//             ),
//             SizedBox(height: 24),
//             Text(
//               'T-shirt History',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(height: 16),
//             Obx(() {
//               if (_tshirtController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (_tshirtController.tshirts.isEmpty) {
//                 return const Center(child: Text('No T-shirt available.'));
//               } else {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: _tshirtController.tshirts.length,
//                     itemBuilder: (context, index) {
//                       var tshirt = _tshirtController.tshirts[index];
//                       final formattedPrice = NumberFormat.currency(
//                               locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
//                           .format(double.parse(tshirt.price));

//                       return Card(
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         child: ListTile(
//                           title: Text('Size: ${tshirt.size}'),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Price: $formattedPrice'),
//                               Text('Quantity: ${tshirt.quantity}'),
//                             ],
//                           ),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 onPressed: () {
//                                   Get.to(() =>
//                                       EditTshirtForm(tshirtId: tshirt.id));
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 onPressed: () {
//                                   _tshirtController.deleteTshirt(id: tshirt.id);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/tshirt_controller.dart';
import 'package:frontendapp/views/Admin/tshirt/create_tshirt.dart';
import 'package:frontendapp/views/Admin/tshirt/edit_tshirt.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class IndexTshirt extends StatelessWidget {
  IndexTshirt({Key? key}) : super(key: key);

  final TshirtController _tshirtController = Get.put(TshirtController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.indigo[600],
        title: Text(
          'T-shirt List',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => CreateTshirtForm());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                shadowColor: Colors.blue[800],
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Add T-shirt',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'T-shirt History',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (_tshirtController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_tshirtController.tshirts.isEmpty) {
                return const Center(child: Text('No T-shirt available.☹️☹️'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _tshirtController.tshirts.length,
                    itemBuilder: (context, index) {
                      var tshirt = _tshirtController.tshirts[index];
                      final formattedPrice = NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: 'Rp.',
                        decimalDigits: 0,
                      ).format(double.parse(tshirt.price));

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            'Size: ${tshirt.size}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price: $formattedPrice',
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Quantity: ${tshirt.quantity}',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue[600],
                                ),
                                onPressed: () {
                                  Get.to(() =>
                                      EditTshirtForm(tshirtId: tshirt.id));
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _tshirtController.deleteTshirt(id: tshirt.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
