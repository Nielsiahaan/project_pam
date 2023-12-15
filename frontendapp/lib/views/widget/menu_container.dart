import 'package:flutter/material.dart';

class MenuContainer extends StatefulWidget {
  final IconData icon;
  final String title;

  MenuContainer({required this.icon, required this.title});

  @override
  _MenuContainerState createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isHovered
              ? Colors.blue[800] ?? Colors.blue
              : Colors.blue[450] ?? Colors.blue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(widget.icon, size: 20, color: Colors.white),
            ),
            SizedBox(width: 8),
            Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
