import 'package:flutter/material.dart';
import 'package:redawn/ui/moodTracker.dart';
import '../theme.dart';
import 'mood_analysis.dart';
import 'userProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redawn/ui/badMoodNotification.dart';
import 'package:redawn/ui/crisisAlertNotification.dart';
import 'package:redawn/ui/journal.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 2;
  bool _showIndicator = false;
  final bool _isLoading = false;

  static final List<String> pageTitles = [
    'Mood Analysis',
    'Healing Hub',
    'Home Page',
    'Diary',
    'User Profile',
  ];

  static final List<Widget> widgetOptions = <Widget>[
    // Add your pages here
    const MoodAnalysisPage(),
    const Text('Healing Hub Coming Soon'),
    const HomePageContent(),
    MoodCalendar(),
    const UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showIndicator = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_selectedIndex]),
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/mood.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/heart.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/home.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/diary.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/user.png')),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.buttonColor,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  Future<String> _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return 'Guest'; // Default name if no user is logged in
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      return userDoc.data()?['displayName'] ?? 'Guest';
    } else {
      return 'Guest';
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, d MMMM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.yellow,
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
            const SizedBox(height: 10),
            FutureBuilder<String>(
              future: _fetchUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    "Loading...",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    "Error",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  );
                } else {
                  return Text(
                    "Hi ${snapshot.data}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  );
                }
              },
            ),
            const SizedBox(height: 5),
            Text(
              _getCurrentDate(),
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/homepageCat.png',
                    width: 120, height: 120),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "How are you feeling now?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoodTrackerPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Text(
                          "Check Mood",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
