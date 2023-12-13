import 'package:flutter/material.dart';
// import 'package:frontendapp/models/mahasiswa_model.dart';
import 'package:frontendapp/views/widget/drawer_widget.dart';
import 'package:frontendapp/views/widget/menu_container.dart';
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
        backgroundColor: Colors.blue[400],
        title: Text('Home'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, User',
                      style: GoogleFonts.poppins(fontSize: 24)),
                  SizedBox(height: 8),
                  Text(
                    '23 Jan 2021',
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: [
                  MenuContainer(icon: Icons.home, title: 'Home'),
                  MenuContainer(icon: Icons.mail, title: 'Messages'),
                  MenuContainer(icon: Icons.calendar_today, title: 'Calendar'),
                  MenuContainer(icon: Icons.assignment, title: 'Assignments'),
                  MenuContainer(icon: Icons.person, title: 'Profile'),
                  MenuContainer(icon: Icons.settings, title: 'Settings'),
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
