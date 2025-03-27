import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';

class CrisisAlertNotification {
  static void showCrisisAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Color(0xFFD6C9),
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
                  'MeowMi notices you\'ve been feeling down for a few days.',
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
                  'Would you like to talk to someone close to you or schedule a session with a consultant mentor?',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Contact'),
            ),
            TextButton(
              onPressed: () {
                
                Navigator.of(context).pop();
              },
              child: const Text('Counselling'),
            ),
          ],
        );
      },
    );
  }
}
