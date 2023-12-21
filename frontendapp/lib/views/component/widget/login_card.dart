import 'package:flutter/material.dart';
import 'package:frontendapp/views/component/widget/email_field.dart';
import 'package:frontendapp/views/component/widget/logo_widget.dart';
import 'package:frontendapp/views/component/widget/no_account_text.dart';
import 'package:frontendapp/views/component/widget/password_text.dart';
import 'package:frontendapp/views/component/widget/remember_me.dart';
import 'package:frontendapp/views/component/widget/rich_text.dart';
import 'package:frontendapp/views/component/widget/sigin_button.dart';
import 'package:frontendapp/views/component/widget/social_button.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({
    super.key,
  });
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return buildCard(size);
  }

  Widget buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      width: size.width * 0.9,
      height: size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoWidget(height: size.height / 8, width: size.height / 8),
                SizedBox(
                  height: size.height * 0.01,
                ),
                const RichTextWidget()
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailTextWidget(
                    controller: _emailController,
                    obscureText: false,
                    size: size,
                    label: 'email',
                    prefixIcon: Icon(
                      Icons.mail_outline_rounded,
                      color: _emailController.text.isEmpty
                          ? const Color(0xFF151624).withOpacity(0.5)
                          : const Color.fromRGBO(44, 185, 176, 1), size: 16,
                    )),
                SizedBox(
                  height: size.height * 0.02,
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
                  height: size.height * 0.01,
                ),
                RememberForgetSection()
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                NoAccountText(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SocialButton(size: size)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
