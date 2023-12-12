import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // greetings row
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                // Hi User
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Daniel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '23 Jan 2021',
                      style: TextStyle(color: Colors.blue[200]),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(Icons.notifications, color: Colors.white))
              ]),
              const SizedBox(
                height: 20,
              ),
              // search bar
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How do you feel?',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              // 4 different faces
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        
                      ],
                    ),
                  ),
                  // bad

                  //fine

                  //we
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
