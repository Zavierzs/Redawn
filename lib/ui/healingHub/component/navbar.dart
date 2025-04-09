import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final Function(int) onTabChange; // Callback to handle tab change

  // Constructor to accept the callback
  const NavBar({required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              onTabChange(0); // Switch to the History tab
            },
            child: Text('History', style: TextStyle(color: Colors.teal)),
          ),
          TextButton(
            onPressed: () {
              onTabChange(1); // Switch to the Favourites tab
            },
            child: Text('Favourites', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }
}
