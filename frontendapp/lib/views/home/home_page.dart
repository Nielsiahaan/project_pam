import 'package:flutter/material.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/booking_room_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/requestIB_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/requestik_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_page.dart';
// import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:frontendapp/views/component/widget/menu_container.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:frontendapp/controllers/authentication.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Welcome Mahasiswa',
          style: TextStyle(color: Colors.white),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   onPressed: () {
        //     _scaffoldKey.currentState?.openDrawer();
        //   },
        // ),
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
              // Greetings row
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Text('Welcome to dashboard Mahasiswa',
              //         style: GoogleFonts.poppins(
              //             fontSize: 20, fontWeight: FontWeight.w500)),
              //   ],
              // ),
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
              Column(
                children: [
                  Row(
                    children: [
                      // Fitur 1: Izin Keluar
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => IzinKeluarPage());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.exit_to_app,
                              title: 'Izin Keluar',
                            ),
                          ),
                        ),
                      ),
                      // Fitur 2: Izin Bermalam
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => IzinBermalamPage());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.hotel,
                              title: 'Izin Bermalam',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Fitur 3: Request Surat
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SuratRequestPage());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.description,
                              title: 'Request Surat',
                            ),
                          ),
                        ),
                      ),
                      // Fitur 4: Booking Room
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => BookingRoomPage());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.meeting_room,
                              title: 'Booking Room',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // drawer: DrawerWidget(),
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
                _showUserInfo(); // Show user information dialog
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

  void _showUserInfo() {
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
    _showUserInfo();
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
