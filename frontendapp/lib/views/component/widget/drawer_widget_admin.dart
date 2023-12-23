import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:get/get.dart';

class DrawerWidgetAdmin extends StatefulWidget {
  const DrawerWidgetAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidgetAdmin> createState() => _DrawerWidgetAdminState();
}

class _DrawerWidgetAdminState extends State<DrawerWidgetAdmin> {
  final _authenticationController = Get.put(AuthenticationController());

  Map<String, IconData> menuIcons = {
    'Settings': Icons.settings,
    'Sign Out': Icons.logout,
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
              title: Text(menu),
              onTap: () {
                // Handle menu item tap
                if (menu == 'Sign Out') {
                  _handleSignOut();
                } else {
                  // Handle other menu items
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
