import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.height, required this.width});
  final double height, width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/img/logoDel.png',
      height: height,
      width: width,
    );
  }
}
