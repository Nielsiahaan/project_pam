import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/authentikasi/login_page.dart';
import 'package:frontendapp/views/component/widget/footer.dart';
import 'package:frontendapp/views/component/widget/input_text_field.dart';
import 'package:frontendapp/views/component/widget/logo_widget.dart';
import 'package:frontendapp/views/component/widget/password_text.dart';
import 'package:frontendapp/views/component/widget/rich_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nimController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _noKTPController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _passwordVisible = false;
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  LogoWidget(height: size.height / 10, width: size.height / 10),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  const RichTextWidget(),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  // Input fields
                  InputFieldWidget(
                    controller: _nimController,
                    size: size,
                    label: 'NIM',
                    prefixIcon: Icon(Icons.account_circle,
                        color: _nimController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  InputFieldWidget(
                    controller: _nameController,
                    size: size,
                    label: 'Full Name',
                    prefixIcon: Icon(Icons.account_circle,
                        color: _nameController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  InputFieldWidget(
                    controller: _usernameController,
                    size: size,
                    label: 'Username',
                    prefixIcon: Icon(Icons.account_circle,
                        color: _usernameController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  InputFieldWidget(
                    controller: _emailController,
                    size: size,
                    label: 'Email',
                    prefixIcon: Icon(Icons.mail_outline_rounded,
                        color: _emailController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  InputFieldWidget(
                    controller: _noTelpController,
                    size: size,
                    label: 'Phone Number',
                    prefixIcon: Icon(Icons.phone,
                        color: _noTelpController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  InputFieldWidget(
                    controller: _noKTPController,
                    size: size,
                    label: 'ID Card Number',
                    prefixIcon: Icon(Icons.credit_card,
                        color: _noKTPController.text.isEmpty
                            ? const Color(0xFF151624).withOpacity(0.5)
                            : const Color.fromRGBO(44, 185, 176, 1),
                        size: 16),
                  ),
                  PasswordTextField(
                    controller: _passwordController,
                    obscureText: true,
                    size: size,
                    passwordVisible: _passwordVisible,
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // SignUp Button
                  GestureDetector(
                    onTap: () async {
                      await _authenticationController.register(
                        nim: _nimController.text.trim(),
                        name: _nameController.text.trim(),
                        username: _usernameController.text.trim(),
                        email: _emailController.text.trim(),
                        no_telp: _noTelpController.text.trim(),
                        no_ktp: _noKTPController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
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
                                'Sign Up',
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
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  // Footer
                  Footer(
                    size: size,
                    text1: 'Already have an account?',
                    text2: 'Sign In',
                    onTap: () {
                      Get.to(const LoginPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
