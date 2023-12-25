import 'package:flutter/material.dart';
import 'package:frontendapp/views/Admin/RequestIK/index_IK.dart';
import 'package:frontendapp/views/Admin/bookingRoom/index.dart';
import 'package:frontendapp/views/Admin/requestIB/index_ib.dart';
import 'package:frontendapp/views/Admin/requestSurat/index_surat.dart';
import 'package:frontendapp/views/Admin/room/index_room.dart';
import 'package:frontendapp/views/Admin/tshirt/index_tshirt.dart';
import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
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
      drawer: const DrawerWidget(),
    );
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
