import 'package:flutter/material.dart';
import 'package:redawn/services/auth_service.dart';
import 'package:redawn/ui/login.dart';
import '../theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _auth = AuthService();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  bool _isHovering = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.buttonColor,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Sign Up For an Account',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF228B22),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController, // Assign the controller
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.email, color: AppTheme.buttonColor),
                  hintText: 'Email Address',
                  filled: true,
                  fillColor: AppTheme.primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _userNameController, // Assign the controller
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person, color: AppTheme.buttonColor),
                  hintText: 'User Name',
                  filled: true,
                  fillColor: AppTheme.primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController, // Assign the controller
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.lock, color: AppTheme.buttonColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppTheme.buttonColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Password',
                  filled: true,
                  fillColor: AppTheme.primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController, // Assign the controller
                obscureText: !_isConfirmPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.lock, color: AppTheme.buttonColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppTheme.buttonColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  hintText: 'Confirm Password',
                  filled: true,
                  fillColor: AppTheme.primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Access the text from the controllers
                  String email = _emailController.text;
                  String userName = _userNameController.text;
                  String password = _passwordController.text;
                  String confirmPassword = _confirmPasswordController.text;

                  if (password == confirmPassword) {
                    setState(() {
                      _isLoading = true;
                    });

                    // Call the signup method from AuthService
                    await _auth.signup(
                      email: email,
                      password: password,
                      context: context,
                    );

                    setState(() {
                      _isLoading = false;
                    });
                  } else {
                    // Show error message if passwords do not match
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Passwords do not match'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Sign Up',
                        style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await _auth.signInWithGoogle(context: context);
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(40, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Image.asset('assets/images/google-logo.webp',
                        height: 40),
                  ),
                  const Spacer(),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.buttonColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginPage()));
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) {
                        setState(() {
                          _isHovering = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _isHovering = false;
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: _isHovering ? Colors.blue : const Color(0xFF228B22),
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
