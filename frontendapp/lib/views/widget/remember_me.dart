import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RememberForgetSection extends StatefulWidget {
  @override
  _RememberForgetSectionState createState() => _RememberForgetSectionState();
}

class _RememberForgetSectionState extends State<RememberForgetSection> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                rememberMe = !rememberMe;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: rememberMe ? const Color(0xFF21899C) : Colors.transparent,
                border: Border.all(
                  color: const Color(0xFF21899C),
                  width: 1.0,
                ),
              ),
              child: rememberMe
                  ? const Icon(
                      Icons.check,
                      size: 13,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Remember me',
            style: GoogleFonts.inter(
              fontSize: 15.0,
              color: const Color(0xFF0C0D34),
            ),
          ),
          const Spacer(),
          Text(
            'Forgot password?',
            style: GoogleFonts.inter(
              fontSize: 13.0,
              color: const Color(0xFF21899C),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
