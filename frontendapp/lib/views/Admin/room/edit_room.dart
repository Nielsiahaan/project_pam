import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/room_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// class UpdateRoomPage extends StatefulWidget {
//   final int roomId;

//   const UpdateRoomPage({Key? key, required this.roomId}) : super(key: key);

//   @override
//   State<UpdateRoomPage> createState() => _UpdateRoomPageState();
// }

// class _UpdateRoomPageState extends State<UpdateRoomPage> {
//   final RoomController _roomController = Get.find<RoomController>();
//   TextEditingController _roomNameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // Fetch room details when the page is initiated
//     _roomController.getRoomDetails(widget.roomId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Room'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Obx(
//             () {
//               // Display loading indicator while fetching room details
//               if (_roomController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator(color: Colors.blueGrey,));
//               } else {
//                 // Pre-fill the form with room details
//                 _roomNameController.text =
//                     _roomController.selectedRoom.value.roomName;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: _roomNameController,
//                       decoration: InputDecoration(labelText: 'Room Name'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter the room name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _roomController.updateRoom(
//                             roomId: widget.roomId,
//                             nameRoom: _roomNameController.text,
//                           );
//                         }
//                       },
//                       child: Text('Update Room'),
//                     ),
//                   ],
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
class UpdateRoomPage extends StatefulWidget {
  final int roomId;

  const UpdateRoomPage({Key? key, required this.roomId}) : super(key: key);

  @override
  State<UpdateRoomPage> createState() => _UpdateRoomPageState();
}

class _UpdateRoomPageState extends State<UpdateRoomPage> {
  final RoomController _roomController = Get.find<RoomController>();
  late TextEditingController _roomNameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _roomNameController = TextEditingController();
    // Fetch room details when the page is initiated
    _roomController.getRoomDetails(widget.roomId);
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: Text(
          'Update Room',
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
=======
        backgroundColor: Colors.indigo[600],
        title: Text(
          'Update Room',
          style: TextStyle(color: Colors.white),
        ),
>>>>>>> 217f97deb0c189460ebf4cbb66a2059b3740b7fd
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(
            () {
              // Display loading indicator while fetching room details
              if (_roomController.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ));
              } else {
                // Pre-fill the form with room details
                _roomNameController.text =
                    _roomController.selectedRoom.value.roomName;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _roomNameController,
                      decoration: InputDecoration(
                        labelText: 'Room Name',
                        labelStyle: TextStyle(color: Colors.teal[300]),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              BorderSide(color: Colors.teal[300]!, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.teal[300]!, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 1.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red[400]!, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: TextStyle(fontSize: 16, color: Colors.teal[300]),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the room name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _roomController.updateRoom(
                            roomId: widget.roomId,
                            nameRoom: _roomNameController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Update Room',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
=======
                        backgroundColor: Colors.blue[800],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: Text(
                            'Update Room',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
>>>>>>> 217f97deb0c189460ebf4cbb66a2059b3740b7fd
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
