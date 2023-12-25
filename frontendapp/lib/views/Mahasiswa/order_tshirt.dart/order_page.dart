// import 'package:flutter/material.dart';
// import 'package:frontendapp/controllers/order_controller.dart';
// import 'package:frontendapp/views/Mahasiswa/bookingRoom/detail_booking_room.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class OrderTshirtPage extends StatelessWidget {
//   final OrderController _orderController = Get.put(OrderController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Order T-shirt',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             InkWell(
//               onTap: () {
//                 // Get.to(() => BookingForm());
//               },
//               child: Ink(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   color: Colors.green,
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.all(12.0),
//                   child: Center(
//                     child: Text(
//                       'Order T-shirt',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Order History',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             Obx(() {
//               if (_orderController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (_orderController.orders.isEmpty) {
//                 return Center(child: Text('No booking room available.'));
//               } else {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: _orderController.orders.length,
//                     itemBuilder: (context, index) {
//                       var orders = _orderController.orders[index];
//                       return buildIzinTile(
//                         size: orders.selectedSize,
//                         quantity: orders.quantity
//                       );
//                     },
//                   ),
//                 );
//               }
//             })
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildIzinTile({
//     required String size,
//     required int quantity,
//   }) {
//     Color? backgroundColor;

//     // String roomName = _bookingController.getRoomNameById(roomId);


//     return Card(
//       color: backgroundColor,
//       child: ListTile(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Text(
//                 //   // roomName,
//                 //   style: GoogleFonts.poppins(
//                 //     fontSize: 14,
//                 //     fontWeight: FontWeight.w400,
//                 //   ),
//                 // ),
//                 PopupMenuButton<String>(
//                   itemBuilder: (BuildContext context) =>
//                       <PopupMenuEntry<String>>[
//                     const PopupMenuItem<String>(
//                       value: 'view',
//                       child: Text('View Detail'),
//                   //   ),
//                   //   if (status.toLowerCase() == 'pending')
//                   //     const PopupMenuItem<String>(
//                   //       value: 'batal',
//                   //       child: Text('Batal'),
//                   //     ),
//                   // ],
//                   // onSelected: (String value) {
//                   //   handlePopupMenuSelection(value, roomId);
//                   // },
//                 ),
//               ],
//             ),
//             Text(
//               'Waktu Mulai: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(start_time)}',
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             Text(
//               'Waktu Berakhir: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(end_time)}',
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         // subtitle: Text(
//         //   'Status: $status',
//         //   style: GoogleFonts.poppins(
//         //     fontSize: 12,
//         //     fontWeight: FontWeight.w400,
//         //   ),
//         // ),
//       ),
//     );
//   }

//   void handlePopupMenuSelection(String value, int roomId) {
//     switch (value) {
//       case 'view':
//         BookingRoomDetailModal(requestId: roomId);
//         break;
//       case 'batal':
//         // cancelBooking(roomId);
//         break;
//     }
//   }

//   // void cancelBooking(int roomId) {
//   //   var roomName = _bookingController.getRoomNameById(roomId);

//   //   //show a confirmation dialog
//   //   Get.defaultDialog(
//   //     title: 'Cancel Booking',
//   //     middleText: 'Are you sure you want to cancel the booking for $roomName?',
//   //     textCancel: 'No',
//   //     textConfirm: 'Yes',
//   //     confirmTextColor: Colors.white,
//   //     onConfirm: () async {
//   //       //call the cancelBooking  method
//   //       await _bookingController.cancelBooking(roomId);
//   //     },
//   //   );
//   // }
// }
