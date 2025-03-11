import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  button({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF228B22), // Button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Round edges
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Text color
      ),
    );
  }
}