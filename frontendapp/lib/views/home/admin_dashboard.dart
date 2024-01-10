import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/Admin/RequestIK/index_IK.dart';
import 'package:frontendapp/views/Admin/bookingRoom/index.dart';
import 'package:frontendapp/views/Admin/requestIB/index_ib.dart';
import 'package:frontendapp/views/Admin/requestSurat/index_surat.dart';
import 'package:frontendapp/views/Admin/room/index_room.dart';
import 'package:frontendapp/views/Admin/tshirt/index_tshirt.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        centerTitle: true,
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                _showUserProfileDialog();
              },
              child: const CircleAvatar(
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
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
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo, // Warna latar belakang avatar
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/img/Niel.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.indigo),
              title: const Text("Settings", style: TextStyle(color: Colors.indigo)),
              onTap: () {
                Navigator.pop(context);
                _showMahasiswaInfo();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.indigo),
              title: const Text("Sign Out", style: TextStyle(color: Colors.indigo)),
              onTap: () {
                Navigator.pop(context);
                _handleSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMahasiswaInfo() {
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
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.indigo, // Warna latar belakang avatar
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage('assets/img/Niel.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.indigo),
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.indigo),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.indigo)),
          ),
          TextButton(
            onPressed: () {
              String newName = nameController.text;
              String newEmail = emailController.text;

              print("Updated Information - Name: $newName, Email: $newEmail");

              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.indigo)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSignOut() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      await _authenticationController.logout();

      Get.back();
    } catch (e) {
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
