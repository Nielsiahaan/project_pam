import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SignInButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final _authenticationController = Get.put(AuthenticationController());

  SignInButton({
    Key? key,
    required this.passwordController,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        await _authenticationController.login(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFF3c8dbc),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Obx(() {
          return _authenticationController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Sign In',
                  style: GoogleFonts.inter(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                );
        }),
      ),
    );
  }
}
