import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';

class BadMoodNotification {
  static void showBadMoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              AppTheme.cardColor,
          title: const Text(
            'Feeling Off Today?',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          content: Column(
            mainAxisSize: MainAxisSize
                .min, // Ensure the dialog doesn't take unnecessary space
            children: [
              const Center(
                child: Text(
                  'MeowMi reminds you to take a break and recharge.',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  textAlign: TextAlign.center, 
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/images/notiCat.png',
                  width: 250,
                  height: 250,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Feel free to share your feelings and thoughts with me!',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  textAlign: TextAlign.center, 
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Dismiss'),
            ),
            TextButton(
              onPressed: () {
                // Add any additional action here, e.g., navigate to a mood tracker
                Navigator.of(context).pop();
              },
              child: const Text('Check Mood'),
            ),
          ],
        );
      },
    );
  }
}
