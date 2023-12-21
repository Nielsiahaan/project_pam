import 'package:flutter/material.dart';
import 'package:frontendapp/views/authentikasi/registrasi_page.dart';
import 'package:frontendapp/views/component/widget/login_card.dart';
import 'package:frontendapp/views/component/widget/footer.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginCard(),
              Footer(
                size: size,
                text1: 'Doesn\'t have an account?',
                text2: 'Sign Up',
                onTap: () {
                  Get.to(const RegisterPage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
