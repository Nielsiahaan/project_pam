import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/Admin/RequestIK/index_IK.dart';
import 'package:frontendapp/views/Admin/bookingRoom/index.dart';
import 'package:frontendapp/views/Admin/requestIB/index_ib.dart';
import 'package:frontendapp/views/Admin/requestSurat/index_surat.dart';
import 'package:frontendapp/views/Admin/room/index_room.dart';
import 'package:frontendapp/views/Admin/tshirt/index_tshirt.dart';
// import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authenticationController = Get.put(AuthenticationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     _scaffoldKey.currentState?.openDrawer();
        //   },
        // ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.notifications),
        //     onPressed: () {
        //       // Handle notifications
        //     },
        //   ),
        // ],
         actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 16.0), // Adjust the right padding as needed
            child: InkWell(
              onTap: () {
                // Tambahkan logika untuk menampilkan informasi pengguna
                // (tampilkan dialog atau pindah ke halaman profil)
                _showUserProfileDialog();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/img/Niel.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Greetings row
              Center(
                child: Text(
                  'Welcome Admin',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Menu containers
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    buildMenuContainer(
                      icon: Icons.meeting_room_outlined,
                      title: 'ROOM',
                      onTap: () {
                        Get.to(() => IndexRoom());
                      },
                    ),
                    buildMenuContainer(
                      icon: Icons.room_outlined,
                      title: 'Booking Room',
                      onTap: () {
                        Get.to(() => IndexBookingRoom());
                      },
                    ),
                    buildMenuContainer(
                      icon: Icons.exit_to_app,
                      title: 'Izin Keluar',
                      onTap: () {
                        Get.to(() => IndexIzinKeluar());
                      },
                    ),
                    buildMenuContainer(
                      icon: Icons.hotel,
                      title: 'Izin Bermalam',
                      onTap: () {
                        Get.to(() => IndexIzinBermalam());
                      },
                    ),
                    buildMenuContainer(
                      icon: Icons.description,
                      title: 'Request Surat',
                      onTap: () {
                        Get.to(() => IndexSurat());
                      },
                    ),
                    buildMenuContainer(
                      icon: Icons.local_mall,
                      title: 'Pesan Baju',
                      onTap: () {
                        Get.to(() => IndexTshirt());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // drawer: const DrawerWidget(),
    );
  }

  void _showUserProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Handle click on profile picture to show user information
                Navigator.pop(context); // Close the current dialog
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/img/Niel.jpg'),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                // Handle Settings
                Navigator.pop(context); // Close the dialog
                _showMahasiswaInfo(); // Show user information dialog
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Sign Out"),
              onTap: () {
                // Handle Sign Out
                Navigator.pop(context); // Close the dialog
                _handleSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMahasiswaInfo() {
    // Create controllers for editing
    TextEditingController nameController =
        TextEditingController(text: "Daniel Siahaan");
    TextEditingController emailController =
        TextEditingController(text: "dsiahaan@gmail.com");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Handle click on profile picture to show user information
                Navigator.pop(context); // Close the current dialog
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/img/Niel.jpg'),
              ),
            ),
            SizedBox(height: 10),
            // Editable fields for name and email
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Save changes and update the user information
              String newName = nameController.text;
              String newEmail = emailController.text;

              // TODO: Update user information with newName and newEmail
              // For now, just print the updated information
              print("Updated Information - Name: $newName, Email: $newEmail");

              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSettings() async {
    _showMahasiswaInfo();
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

  Widget buildMenuContainer({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.indigo,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
