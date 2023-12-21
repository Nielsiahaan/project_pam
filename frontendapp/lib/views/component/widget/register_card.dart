// import 'package:flutter/material.dart';
// import 'package:frontendapp/views/widget/input_text_field.dart';
// import 'package:frontendapp/views/widget/logo_widget.dart';
// import 'package:frontendapp/views/widget/password_text.dart';
// // import 'package:frontendapp/views/widget/remember_me.dart';
// import 'package:frontendapp/views/widget/rich_text.dart';
// import 'package:frontendapp/views/widget/sigin_button.dart';


// class RegisterCard extends StatefulWidget {
//   const RegisterCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _RegisterCardState createState() => _RegisterCardState();
// }

// class _RegisterCardState extends State<RegisterCard> {
//   TextEditingController _nimController = TextEditingController();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _noTelpController = TextEditingController();
//   TextEditingController _noKTPController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   bool _passwordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return buildCard(size);
//   }

//   Widget buildCard(Size size) {
//     return Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       width: size.width * 1,
//       height: size.height * 0.9,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         color: Color(0xFFFFFFFF),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Logo and RichTextWidget
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               LogoWidget(height: size.height / 12, width: size.height / 12),
//               SizedBox(
//                 height: size.height * 0.01,
//               ),
//               // RichTextWidget(),
//             ],
//           ),
//           // Input fields
//           Expanded(
//             child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(0),
//               children: [
//                 InputTextField(
//                   controller: _nimController,
//                   obscureText: false,
//                   size: size,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 InputTextField(
//                   controller: _nameController,
//                   obscureText: false,
//                   size: size,
//                 ),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 InputTextField(
//                     controller: _usernameController,
//                     obscureText: false,
//                     size: size),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 InputTextField(
//                     controller: _emailController,
//                     prefixIcon: Icon(
//                       Icons.mail_outline_rounded,
//                       color: _emailController.text.isEmpty
//                           ? const Color(0xFF151624).withOpacity(0.5)
//                           : const Color.fromRGBO(44, 185, 176, 1),
//                       size: 16,
//                     ),
//                     obscureText: false,
//                     size: size),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 InputTextField(
//                     controller: _noTelpController,
//                     obscureText: false,
//                     size: size),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 InputTextField(
//                     controller: _noKTPController,
//                     obscureText: false,
//                     size: size),
//                 SizedBox(
//                   height: size.height * 0.02,
//                 ),
//                 PasswordTextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   size: size,
//                   passwordVisible: _passwordVisible,
//                   onPressed: () {
//                     setState(() {
//                       _passwordVisible = !_passwordVisible;
//                     });
//                   },
//                 ),
//                 // SizedBox(
//                 //   height: size.height * 0.01,
//                 // ),
//                 // RememberForgetSection()
//               ],
//             ),
//           ),
//           SizedBox(
//             height: size.height * 0.01,
//           ),
//           // SignInButton
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SignInButton(
//                 emailController: _emailController,
//                 passwordController: _passwordController,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
