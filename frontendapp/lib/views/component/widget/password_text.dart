import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {super.key,
      required this.controller,
      required this.obscureText,
      required this.size, required this.passwordVisible, this.onPressed});
  final TextEditingController controller;
  final bool obscureText;
  final Size size;
  final bool passwordVisible;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.height / 12,
        child: TextFormField(
          controller: controller,
          style: GoogleFonts.inter(
            fontSize: 18.0,
            color: const Color(0xFF151624),
          ),
          maxLines: 1,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !passwordVisible,
          cursorColor: const Color(0xFF151624),
          decoration: InputDecoration(
            // hintText: 'Enter your password',
            labelText: 'password',
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
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: controller.text.isEmpty
                  ? const Color(0xFF151624).withOpacity(0.5)
                  : const Color.fromRGBO(44, 185, 176, 1),
              size: 16,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: onPressed,
            ),
          ),
        ));
  }
}
