import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextWidget extends StatelessWidget {
  const EmailTextWidget(
      {required this.controller,
      required this.obscureText,
      required this.size, this.prefixIcon, required this.label});

  final TextEditingController controller;
  final bool obscureText;
  final Size size;
   final String label;
  final Widget? prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height / 12,
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.inter(
                fontSize: 18.0,
                color: const Color(0xFF151624),
              ),
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              cursorColor: const Color(0xFF151624),
              decoration: InputDecoration(
                // hintText: 'Enter your email',
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
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(44, 185, 176, 1),
                    )),
                prefixIcon: prefixIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
