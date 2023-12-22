import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/room_controller.dart';
import 'package:frontendapp/views/Admin/room/create_room.dart';
import 'package:frontendapp/views/Admin/room/edit_room.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IndexRoom extends StatelessWidget {
  IndexRoom({Key? key}) : super(key: key);

  final RoomController _roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Index Room',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => CreateRoomPage());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'Add Room',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'History Request Surat',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            Obx(() {
              if (_roomController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (_roomController.rooms.isEmpty) {
                return Center(child: Text('No surat requests available.'));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _roomController.rooms.length,
                    itemBuilder: (context, index) {
                      var room = _roomController.rooms[index];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(room.roomName),
                          // subtitle: Text('Room ID: ${room.id}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                 Get.to(() => UpdateRoomPage(roomId: room.id!));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _roomController.deleteRoom(roomId: room.id!);
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
