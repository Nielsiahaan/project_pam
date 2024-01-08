import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/room_controller.dart';
import 'package:get/get.dart';

class UpdateRoomPage extends StatefulWidget {
  final int roomId;

  const UpdateRoomPage({Key? key, required this.roomId}) : super(key: key);

  @override
  State<UpdateRoomPage> createState() => _UpdateRoomPageState();
}

class _UpdateRoomPageState extends State<UpdateRoomPage> {
  final RoomController _roomController = Get.find<RoomController>();
  TextEditingController _roomNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch room details when the page is initiated
    _roomController.getRoomDetails(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        title: Text(
          'Update Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Obx(
            () {
              // Display loading indicator while fetching room details
              if (_roomController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                // Pre-fill the form with room details
                _roomNameController.text =
                    _roomController.selectedRoom.value.roomName;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _roomNameController,
                      decoration: InputDecoration(labelText: 'Room Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the room name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
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
                        backgroundColor: Colors.blue[800],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Center(
                          child: Text(
                            'Update Room',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
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
