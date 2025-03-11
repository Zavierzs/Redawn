import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/home.dart';
import 'components/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redawn',
      home: const OnboardingScreen(),
      routes: {'/home': (context) => HomePage()},
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;

  final List<String> images = [
    'assets/images/Onboarding1.png',
    'assets/images/Onboarding2.png',
    'assets/images/Onboarding3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stack of images with opacity transition
          for (int i = 0; i < images.length; i++)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _currentIndex == i ? 1.0 : 0.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          // Next button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Center(
              child: button(
                text: _currentIndex == images.length - 1 ? 'Get Started!' : 'Next',
                onPressed: () async {
                  if (_currentIndex < images.length - 1) {
                    setState(() => _currentIndex++);
                  } else {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onBoard', true);
                    if (!mounted) return;
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
