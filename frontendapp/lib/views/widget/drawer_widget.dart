
import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/requestik_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final _authenticationController = Get.put(AuthenticationController());

  Map<String, IconData> menuIcons = {
    'Request IK': Icons.departure_board,
    'Booking Room': Icons.business,
    'Settings': Icons.settings,
    'Sign Out': Icons.exit_to_app,
  };

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Daniel Siahaan"),
            accountEmail: Text("dsiahaan@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/img/Niel.jpg'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[800],
            ),
          ),
          for (var menu in menuIcons.keys)
            ListTile(
              leading: Icon(menuIcons[menu]),
              title: Text(menu, style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 14)),
              onTap: () {
                // Add logic to handle menu taps
                if (menu == 'Sign Out') {
                  _handleSignOut();
                } else if(menu == 'Request IK') {
                  Get.to(()=> IzinKeluarPage());
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
