import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/journalControllers.dart';

class JournalDetailed extends StatelessWidget {
  final DateTime selectedDate;

  const JournalDetailed({Key? key, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController responseController = TextEditingController();
    final JournalController controller = JournalController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Journal Entry'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMMM d, yyyy').format(selectedDate),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Got something on your mind? Let it out here!',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text(
              'Express your feelings—whether it\'s joy, sadness, or anything in between.',
              style: TextStyle(fontSize: 16, color: Colors.teal.shade700),
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
                  borderSide: BorderSide(color: Colors.teal),
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
                      await controller.saveEntry(
                        selectedDate,
                        responseController.text,
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter your feelings!')),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade300,
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.asset(
                'assets/images/journalDetailed.png', // Ensure this path is correct
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
