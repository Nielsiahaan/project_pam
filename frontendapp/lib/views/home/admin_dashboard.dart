import 'package:flutter/material.dart';
import 'package:frontendapp/views/Admin/requestSurat/index_surat.dart';
import 'package:frontendapp/views/Admin/room/index_room.dart';
import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:frontendapp/views/component/widget/menu_container.dart';
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
      backgroundColor: Colors.grey[100],
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Home',
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
              // Greetings row
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome Admin',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                ],
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
              Column(
                children: [
                  Row(
                    children: [
                      // Fitur 1: CRUD Room
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => IndexRoom());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.meeting_room_outlined,
                              title: 'ROOM',
                            ),
                          ),
                        ),
                      ),
                      // Fitur 2: Izin Bermalam
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(() => IzinBermalamPage());
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
                            Get.to(() => IndexSurat());
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
                            // Get.to(() => BookingRoomPage());
                          },
                          child: Card(
                            child: MenuContainer(
                              icon: Icons.room_outlined,
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
      drawer: DrawerWidget(),
    );
  }
}
