import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';

class NavBar extends StatelessWidget {
  final Function(int) onTabChange; // Callback to handle tab change

  // Constructor to accept the callback
  const NavBar({required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  onTabChange(0); // Switch to the History tab
                },
                child: Row(
                  children: [
                    Icon(Icons.history,
                        color: AppTheme.buttonColor), 
                    const SizedBox(width: 4), 
                    Text('History',
                        style: TextStyle(color: AppTheme.buttonColor)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  onTabChange(1); // Switch to the Favourites tab
                },
                child: Row(
                  children: [
                    Icon(Icons.favorite,
                        color: AppTheme.buttonColor), 
                    const SizedBox(width: 4), 
                    Text('Favourites',
                        style: TextStyle(color: AppTheme.buttonColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
