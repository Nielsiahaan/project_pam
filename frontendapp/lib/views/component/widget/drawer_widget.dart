import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/booking_room_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/requestIB_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/requestik_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_page.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _authenticationController = Get.put(AuthenticationController());

  Map<String, IconData> menuIcons = {
    'Request IK': Icons.access_time,
    'Request IB': Icons.hotel,
    'Request Surat': Icons.description,
    'Booking Room': Icons.meeting_room,
    'Settings': Icons.settings,
    'Sign Out': Icons.logout,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.teal,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.teal,
                    width: 0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/img/Niel.jpg'),
                    radius: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Daniel Siahaan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "dsiahaan@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (var menu in menuIcons.keys)
            ListTile(
              leading: Icon(
                menuIcons[menu],
                color: Colors.teal,
              ),
              title: Text(
                menu,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.teal,
                ),
              ),
              onTap: () {
                // Add logic to handle menu taps
                if (menu == 'Sign Out') {
                  _handleSignOut();
                } else if (menu == 'Request IK') {
                  Get.to(() => IzinKeluarPage());
                } else if (menu == 'Request Surat') {
                  Get.to(() => SuratRequestPage());
                } else if (menu == 'Request IB') {
                  Get.to(() => IzinBermalamPage());
                } else if (menu == 'Booking Room') {
                  Get.to(() => BookingRoomPage());
                }
              },
            ),
        ],
      ),
    );
  }

  Future<void> _handleSignOut() async {
    try {
      // Show loading indicator
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // Call logout method
      await _authenticationController.logout();

      // Close loading indicator
      Get.back();
    } catch (e) {
      // Handle error (if any)
      debugPrint('Error during logout: ${e.toString()}');
      Get.back();
    }
  }
}
