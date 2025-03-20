import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../theme.dart';
import 'login.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserCredentials _userCredentials = UserCredentials();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _realNameController = TextEditingController();
  final TextEditingController _nricController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await _userCredentials.loadFromPreferences();
    setState(() {
      _emailController.text = _userCredentials.email ?? '';
      _displayNameController.text = _userCredentials.displayName ?? '';
      _realNameController.text = _userCredentials.realName ?? '';
      _nricController.text = _userCredentials.nric ?? '';
      _addressController.text = _userCredentials.address ?? '';
      _phoneNumberController.text = _userCredentials.phoneNumber ?? '';
      _ageController.text = _userCredentials.age?.toString() ?? '';
      _genderController.text = _userCredentials.gender ?? '';
      _heightController.text = _userCredentials.height?.toString() ?? '';
      _weightController.text = _userCredentials.weight?.toString() ?? '';
    });
  }

  Future<void> _saveUserData() async {
    _userCredentials.updateUser(
      email: _emailController.text,
      displayName: _displayNameController.text,
      realName: _realNameController.text,
      nric: _nricController.text,
      address: _addressController.text,
      phoneNumber: _phoneNumberController.text,
      age: int.tryParse(_ageController.text),
      gender: _genderController.text,
      height: double.tryParse(_heightController.text),
      weight: double.tryParse(_weightController.text),
    );
    await _userCredentials.saveToPreferences();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User data saved successfully')),
    );
  }

  Future<void> _logout() async {
    await AuthService().signout(context: context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _displayNameController,
                decoration: const InputDecoration(labelText: 'Display Name'),
              ),
              TextField(
                controller: _realNameController,
                decoration: const InputDecoration(labelText: 'Real Name'),
              ),
              TextField(
                controller: _nricController,
                decoration: const InputDecoration(labelText: 'NRIC'),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUserData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 187, 30, 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Log Out', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
