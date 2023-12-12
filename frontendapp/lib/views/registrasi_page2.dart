import 'package:flutter/material.dart';
import 'package:frontendapp/controllers/authentication.dart';
import 'package:frontendapp/views/login_page.dart';
import 'package:frontendapp/views/widget/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();

  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Register Page',
              style: GoogleFonts.poppins(fontSize: size * 0.080),
            ),
            const SizedBox(height: 30),
            InputWidget(
              hintText: 'Name',
              obscureText: false,
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            InputWidget(
              hintText: 'Username',
              obscureText: false,
              controller: _usernameController,
            ),
            const SizedBox(height: 20),
            InputWidget(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            InputWidget(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () async {
                await _authenticationController.register(
                  name: _nameController.text.trim(),
                  username: _usernameController.text.trim(),
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              child: Obx(() {
                return _authenticationController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Text(
                        'Register',
                        style: GoogleFonts.poppins(fontSize: size * 0.040),
                      );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Get.to(const LoginPage());
              },
              child: Text('Login',
                  style: GoogleFonts.poppins(
                      fontSize: size * 0.040, color: Colors.black)),
            )
          ]),
        ),
      ),
    );
  }
}
