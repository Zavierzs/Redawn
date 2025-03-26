import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../theme.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserCredentials _userCredentials = UserCredentials();
  User? _user;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _realNameController = TextEditingController();
  final TextEditingController _nricController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      _user = await _userCredentials.loadFromFirestore();
      if (_user != null) {
        setState(() {
          _emailController.text = _user!.email;
          _displayNameController.text = _user!.displayName;
          _realNameController.text = _user!.realName ?? '';
          _nricController.text = _user!.nric ?? '';
          _addressController.text = _user!.address ?? '';
          _phoneNumberController.text = _user!.phoneNumber ?? '';
          _ageController.text = _user!.age?.toString() ?? '';
          _genderController.text = _user!.gender ?? '';
        });
      } else {
        // Handle case where user data is not found
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User data not found.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: $e')),
      );
    }
  }

  Future<void> _saveUserData() async {
    try {
      if (_user == null) {
        return;
      }
      final updatedUser = User(
        uid: _user!.uid,
        email: _emailController.text.isNotEmpty
            ? _emailController.text
            : _user!.email,
        displayName: _displayNameController.text.isNotEmpty
            ? _displayNameController.text
            : _user!.displayName,
        profilePicUrl: _user!.profilePicUrl, //keep the same profile pic url
        realName: _realNameController.text.isNotEmpty
            ? _realNameController.text
            : _user!.realName,
        nric: _nricController.text.isNotEmpty
            ? _nricController.text
            : _user!.nric,
        address: _addressController.text.isNotEmpty
            ? _addressController.text
            : _user!.address,
        phoneNumber: _phoneNumberController.text.isNotEmpty
            ? _phoneNumberController.text
            : _user!.phoneNumber,
        age: int.tryParse(_ageController.text) ?? _user!.age,
        gender: _genderController.text.isNotEmpty
            ? _genderController.text
            : _user!.gender,
      );
      await _userCredentials.saveToFirestore(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User data saved successfully')),
      );
      _loadUserData(); //reload the data to update the user object
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving user data: $e')),
      );
    }
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
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
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
                child: const Text('Log Out',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
