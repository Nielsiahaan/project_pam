import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const PostField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey[200]),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)),
      ),
    );
  }
}
