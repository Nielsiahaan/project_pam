import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer(
      {super.key,
      required this.size,
      this.onTap,
      required this.text1,
      required this.text2});
  final Size size;
  final String text1;
  final String text2;
  final Callback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.03),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: Colors.black,
          ),
          children: [
             TextSpan(
              text: text1,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
           const TextSpan(text: ' '),
            TextSpan(
                text: text2,
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                  color:const  Color(0xFFFF7248),
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
