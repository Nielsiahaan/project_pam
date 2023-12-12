import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
            flex: 2,
            child: Divider(
              color: Color(0xFF969AA8),
            )),
        Expanded(
          flex: 3,
          child: Text(
            'Don’t Have Account?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
              fontWeight: FontWeight.w500,
              height: 1.67,
            ),
          ),
        ),
        const Expanded(
            flex: 2,
            child: Divider(
              color: Color(0xFF969AA8),
            )),
      ],
    );
  }
}
