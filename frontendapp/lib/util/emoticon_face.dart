import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  const EmoticonFace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Search',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
