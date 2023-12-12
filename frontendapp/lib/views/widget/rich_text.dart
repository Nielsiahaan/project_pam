import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 12,
          color: const Color(0xFF21899C),
          letterSpacing: 1,
        ),
        children: [
          TextSpan(
            text: 'Institut Teknologi Del',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
