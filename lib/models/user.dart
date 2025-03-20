import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String uid;
  final String email;
  final String displayName;
  final String profilePicUrl;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.profilePicUrl,
  });

  // Method to convert FirebaseUser to User
  factory User.fromFirebaseUser(auth.User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      profilePicUrl: firebaseUser.photoURL ?? '',
    );
  }

  // Method to fetch user data
  Map<String, String?> getUserData() {
    return {
      'email': email,
      'uid': uid,
      'displayName': displayName,
      'profilePicUrl': profilePicUrl,
    };
  }
}

// Singleton class to store user credentials
class UserCredentials {
  // Private constructor
  UserCredentials._privateConstructor();

  // Singleton instance
  static final UserCredentials _instance =
      UserCredentials._privateConstructor();

  // Factory constructor to return the same instance
  factory UserCredentials() {
    return _instance;
  }

  // User infos
  String? email;
  String? password;
  String? uid;
  String? displayName;
  String? profilePicUrl;
  String? realName;
  String? nric;
  String? address;
  String? phoneNumber;
  int? age;
  String? gender;
  double? height;
  double? weight;

  // Method to update user details
  void updateUser({
    String? displayName,
    String? profilePicUrl,
    String? email,
    String? address,
    String? realName,
    String? nric,
    String? phoneNumber,
    int? age,
    String? gender,
    double? height,
    double? weight,
  }) {
    this.displayName = displayName;
    this.profilePicUrl = profilePicUrl;
    this.email = email;
    this.address = address;
    this.realName = realName;
    this.nric = nric;
    this.phoneNumber = phoneNumber;
    this.age = age;
    this.gender = gender;
    this.height = height;
    this.weight = weight;
  }

  // Method to fetch user data
  // Save user data to shared preferences
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email ?? '');
    await prefs.setString('uid', uid ?? '');
    await prefs.setString('displayName', displayName ?? '');
    await prefs.setString('profilePicUrl', profilePicUrl ?? '');
    await prefs.setString('realName', realName ?? '');
    await prefs.setString('nric', nric ?? '');
    await prefs.setString('address', address ?? '');
    await prefs.setString('phoneNumber', phoneNumber ?? '');
    await prefs.setInt('age', age ?? 0);
    await prefs.setString('gender', gender ?? '');
    await prefs.setDouble('height', height ?? 0.0);
    await prefs.setDouble('weight', weight ?? 0.0);
  }

  // Load user data from shared preferences
  Future<void> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    uid = prefs.getString('uid');
    displayName = prefs.getString('displayName');
    profilePicUrl = prefs.getString('profilePicUrl');
    realName = prefs.getString('realName');
    nric = prefs.getString('nric');
    address = prefs.getString('address');
    phoneNumber = prefs.getString('phoneNumber');
    age = prefs.getInt('age');
    gender = prefs.getString('gender');
    height = prefs.getDouble('height');
    weight = prefs.getDouble('weight');
  }
}
