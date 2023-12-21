import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFieldWidget extends StatelessWidget {
  const InputFieldWidget(
      {super.key,
      required this.controller,
      required this.size,
      required this.label,
      this.prefixIcon});

  final TextEditingController controller;
  final Size size;
  final String label;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      controller: controller,
      style: GoogleFonts.inter(
        fontSize: 18.0,
        color: const Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress, // Sesuaikan sesuai kebutuhan
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        labelText: label,
        hintStyle: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        fillColor: controller.text.isNotEmpty
            ? Colors.transparent
            : const Color.fromRGBO(248, 247, 251, 1),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(
            color: controller.text.isEmpty
                ? Colors.transparent
                : const Color.fromRGBO(44, 185, 176, 1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Color.fromRGBO(44, 185, 176, 1),
          ),
        ),
        prefixIcon: prefixIcon,
      ),
    ),
  );
  }
}
