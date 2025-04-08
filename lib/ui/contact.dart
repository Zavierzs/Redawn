import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Contacts',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, 
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.buttonColor,
                    child: Icon(
                      Icons.person,
                      color: Colors.white, 
                    ),
                  ),
                  title: Text('Contact ${index + 1}'),
                  subtitle: const Text('Phone: 123-456-7890'),
                  onTap: () {
                    // Handle contact tap
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add contact action
        },
        backgroundColor: AppTheme.buttonColor,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget createContactPage() {
  return const ContactPage();
}
