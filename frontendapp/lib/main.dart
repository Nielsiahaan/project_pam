import 'package:flutter/material.dart';
import 'package:frontendapp/views/home/splash_screen.dart';
import 'package:frontendapp/views/home/home_page.dart';
// import 'package:frontendapp/views/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      
      title: 'Frontend App',
      debugShowCheckedModeBanner: false,
      home: token == null ? const SplashScreen() : const HomePage()
    );

  }
}
