import 'package:flutter/material.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/booking_room_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/requestIB_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/requestik_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_page.dart';
import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:frontendapp/views/component/widget/menu_container.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Text('Welcome to dashboard Mahasiswa',
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
      drawer: DrawerWidget(),
    );
  }
}
