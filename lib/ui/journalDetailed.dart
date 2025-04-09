import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/journalControllers.dart';
import 'package:redawn/theme.dart';

class JournalDetailed extends StatelessWidget {
  final DateTime selectedDate;

  const JournalDetailed({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController responseController = TextEditingController();

    Future<void> saveJournalEntry(String journalText) async {
      try {
        String userId = FirebaseAuth.instance.currentUser?.uid ?? "guest_user";

        String date = DateFormat('yyyy-MM-dd').format(selectedDate);

        DocumentReference userDoc =
            FirebaseFirestore.instance.collection("users").doc(userId);
        await userDoc.collection("moods").doc(date).collection("journal").add({
          "entry": journalText,
          "date": date,
          "timestamp": FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Journal entry saved successfully!")),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save journal entry: $e")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Journal Entry',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE, MMMM d, yyyy').format(selectedDate),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Got something on your mind? Let it out here!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.buttonColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Express your feelings—whether it\'s joy, sadness, or anything in between.',
                style: TextStyle(fontSize: 16, color: AppTheme.buttonColor),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: responseController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type your feelings here...',
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (responseController.text.isNotEmpty) {
                        await saveJournalEntry(responseController.text);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your feelings!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300,
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/journalDetailed.png',
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
