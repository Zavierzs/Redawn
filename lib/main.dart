import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:redawn/services/auth_service.dart';

import 'package:redawn/ui/home.dart';
import 'package:redawn/ui/login.dart';
import 'package:redawn/ui/signup.dart';
import 'package:redawn/ui/userProfile.dart';

import 'components/button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Redawn',
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(), // Automatically redirects user
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/profile': (context) => const UserProfilePage(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool? _showOnboarding; // Use `null` initially to handle async loading

  @override
  void initState() {
    super.initState();
    _checkOnboarding();
  }

  Future<void> _checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('onBoard') ?? false;

    setState(() => _showOnboarding = !seenOnboarding);
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding == null) {
      return const Center(child: CircularProgressIndicator()); // Show loading
    }

    if (_showOnboarding!) {
      return const OnboardingScreen();
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const HomePage(); // User is logged in
        } else {
          return const LoginPage(); // User is not logged in
        }
      },
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthWrapper()));
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
