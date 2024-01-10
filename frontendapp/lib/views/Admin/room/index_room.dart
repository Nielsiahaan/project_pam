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
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Index Room',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => const CreateRoomPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                shadowColor: Colors.blue[800],
                minimumSize: const Size(double.infinity, 50),
                padding: const EdgeInsets.all(15),
              ),
              child: const Text(
                'Add Room',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'History Request Surat',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (_roomController.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ));
              } else if (_roomController.rooms.isEmpty) {
                return Center(
                    child: Text(
                  'No surat requests available.☹️',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ));
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: _roomController.rooms.length,
                    itemBuilder: (context, index) {
                      var room = _roomController.rooms[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(
                            room.roomName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
                                  Get.to(
                                    () => UpdateRoomPage(roomId: room.id!),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
