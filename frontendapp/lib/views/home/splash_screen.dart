import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontendapp/views/authentikasi/login_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.to(() => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo centered at the top
            Container(
              alignment: Alignment.topCenter,
              child: logo(160, 160),
            ),
            const SizedBox(
              height: 25,
            ),
            richText(16),
          ],
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/img/logoDel.png',
      height: height_,
      width: width_,
    );
  }

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: fontSize,
          color: const Color(0xFF21899C),
          letterSpacing: 3,
          height: 1.03,
        ),
        children: const [
          TextSpan(
            text: 'Institut Teknologi Del',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
