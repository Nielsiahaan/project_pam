import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(),
            contentPadding: EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
  }
}
