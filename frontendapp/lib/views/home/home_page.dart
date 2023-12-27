import 'package:flutter/material.dart';
import 'package:frontendapp/views/Mahasiswa/bookingRoom/booking_room_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIB/requestIB_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestIK/requestik_page.dart';
import 'package:frontendapp/views/Mahasiswa/requestSurat/surat_page.dart';
import 'package:frontendapp/views/component/widget/drawer_widget.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

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
        backgroundColor: Colors.teal,
        title: Text(
          'Dashboard Mahasiswa',
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
                            color: Colors.blue,
                            child: MenuContainer(
                              icon: Icons.exit_to_app,
                              title: 'Izin Keluar',
                              textColor: Colors.white,
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
                            color: Colors.deepPurple,
                            child: MenuContainer(
                              icon: Icons.hotel,
                              title: 'Izin Bermalam',
                              textColor: Colors.white,
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
                            color: Colors.green,
                            child: MenuContainer(
                              icon: Icons.description,
                              title: 'Request Surat',
                              textColor: Colors.white,
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
                            color: Colors.orange,
                            child: MenuContainer(
                              icon: Icons.meeting_room,
                              title: 'Booking Room',
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Get.to(() => ());
                          },
                          child: Card(
                            color: Colors.teal,
                            child: MenuContainer(
                              icon: Icons.local_mall,
                              title: 'Order T-shirt',
                              textColor: Colors.white,
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
      drawer: const DrawerWidget(),
    );
  }
}

class MenuContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color textColor;

  const MenuContainer({
    required this.icon,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: textColor),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
