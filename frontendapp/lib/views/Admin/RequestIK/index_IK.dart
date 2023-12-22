// import 'package:flutter/material.dart';
// import 'package:frontendapp/controllers/request_ik_controller.dart';

// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class IndexSurat extends StatelessWidget {
//   IndexSurat({Key? key}) : super(key: key);

//   final RequestIKController _requestIkController =
//       Get.put(RequestIKController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Index Request Surat',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Riwayat Request Surat',
//               style: GoogleFonts.poppins(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(height: 16),
//             Obx(() {
//               if (_requestIkController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (_requestIkController.requestIK.isEmpty) {
//                 return Center(child: Text('No surat requests available.'));
//               } else {
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: [
//                       DataColumn(label: Text('No')),
//                       DataColumn(label: Text('Nama Mahasiswa')),
//                       DataColumn(label: Text('Kategori Surat')),
//                       DataColumn(label: Text('Action')),
//                     ],
//                     rows: List<DataRow>.generate(
//                       _requestIkController.requestIK.length,
//                       (index) {
//                         var requestIK =
//                             _requestIkController.requestIK[index];

//                         return DataRow(
//                           cells: [
//                             DataCell(Text((index + 1).toString())),
//                             DataCell(FutureBuilder<String>(
//                               future: _requestIkController
//                                   .getNamaMahasiswaFromId(
//                                       requestIK.mahasiswaId),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState ==
//                                     ConnectionState.waiting) {
//                                   return CircularProgressIndicator();
//                                 } else if (snapshot.hasError) {
//                                   return Text('Error');
//                                 } else {
//                                   return Text(snapshot.data ?? 'Unknown');
//                                 }
//                               },
//                             )),
//                             DataCell(Text(requestIK.kategoriSurat)),
//                             DataCell(
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(Icons.visibility),
//                                     onPressed: () {
//                                       // TODO: Show modal with detailed information
//                                     },
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.thumb_up),
//                                     onPressed: () {
//                                       // TODO: Call approveSurat function
//                                       _requestIkController.approveSurat(
//                                         id: requestIK.id,
//                                       );
//                                     },
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.thumb_down),
//                                     onPressed: () {
//                                       // TODO: Call rejectSurat function
//                                       _requestIkController.rejectSurat(
//                                         id: requestIK.id,
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
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
