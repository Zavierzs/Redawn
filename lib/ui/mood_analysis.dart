import 'package:flutter/material.dart';
class MoodAnalysisPage extends StatelessWidget {
  const MoodAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Mood Analysis Coming Soon'),
      ),
    );
  }
}

Widget createMoodAnalysisPage() {
  return const MoodAnalysisPage();
}