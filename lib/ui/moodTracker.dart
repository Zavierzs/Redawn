import 'package:flutter/material.dart';
import 'package:redawn/theme.dart';

class MoodTrackerPage extends StatefulWidget {
  const MoodTrackerPage({super.key});

  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  int _selectedMoodIndex = -1;
  Set<String> _selectedReasons = {};
  final TextEditingController _textController =
      TextEditingController(); // Add a controller

  final List<String> _moodImages = [
    'assets/icons/happy.png',
    'assets/icons/relaxed.png',
    'assets/icons/sad.png',
    'assets/icons/angry.png',
  ];

  final List<String> _reasons = [
    'Work',
    'Family',
    'Health',
    'Finance',
    'Relationships',
    'Weather',
    'Traffic',
    'Assignments',
    'Friends',
    'Accomplishments',
    'Failures',
    'Hobbies',
    'Social',
    'Food',
    'Sleep',
  ];

  void _onMoodSelected(int index) {
    setState(() {
      _selectedMoodIndex = index;
    });
  }

  void _onReasonSelected(String reason) {
    setState(() {
      if (_selectedReasons.contains(reason)) {
        _selectedReasons.remove(reason);
      } else {
        _selectedReasons.add(reason);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Mood Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: AppTheme.primaryColor,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Emotions',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_moodImages.length, (index) {
                    return GestureDetector(
                      onTap: () => _onMoodSelected(index),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: _selectedMoodIndex == index
                              ? [
                                  BoxShadow(
                                    color:
                                        AppTheme.buttonColor.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(_moodImages[index]),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _textController, // Attach the controller
                  decoration: InputDecoration(
                    hintText: 'Type Your Reason...',
                    hintStyle:
                        const TextStyle(fontSize: 14), // Adjust hint text size
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12, // Adjust vertical padding
                      horizontal: 16, // Adjust horizontal padding
                    ),
                  ),
                  style:
                      const TextStyle(fontSize: 16), // Adjust input text size
                  onSubmitted: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        return;
                      }

                      // Check if the entered reason exists in the list
                      final matchingReason = _reasons.firstWhere(
                        (reason) => reason.toLowerCase() == value.toLowerCase(),
                        orElse: () => '',
                      );

                      if (matchingReason.isNotEmpty) {
                        // If a match is found, select the reason
                        _selectedReasons.add(matchingReason);
                      } else {
                        // If no match is found, create a temporary button
                        _selectedReasons.add(value);
                      }

                      // Clear the text field
                      _textController.clear();
                    });
                  },
                ),
                const SizedBox(height: 12),
                if (_selectedReasons.isNotEmpty) ...[
                  const Text(
                    'Selected',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _selectedReasons.map((reason) {
                      return ElevatedButton(
                        onPressed: () => _onReasonSelected(reason),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: const BorderSide(color: Colors.green, width: 2),
                        ),
                        child: Text(
                          reason,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 15),
                ],
                const Text(
                  'All Reasons',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _reasons.map((reason) {
                        final isSelected = _selectedReasons.contains(reason);
                        return ElevatedButton(
                          onPressed: () => _onReasonSelected(reason),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? AppTheme.buttonColor
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                                color: isSelected
                                    ? Colors.green
                                    : AppTheme.buttonColor,
                                width: 2),
                          ),
                          child: Text(
                            reason,
                            style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.buttonColor),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle mood submission here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget createMoodTrackerPage() {
  return const MoodTrackerPage();
}
