import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class User {
  final String uid;
  final String email;
  final String displayName;
  final String profilePicUrl;
  final String? realName;
  final String? nric;
  final String? address;
  final String? phoneNumber;
  final int? age;
  final String? gender;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.profilePicUrl,
    this.realName,
    this.nric,
    this.address,
    this.phoneNumber,
    this.age,
    this.gender,
  });

  factory User.fromFirebaseUser(auth.User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName ?? '',
      profilePicUrl: firebaseUser.photoURL ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'profilePicUrl': profilePicUrl,
      'realName': realName,
      'nric': nric,
      'address': address,
      'phoneNumber': phoneNumber,
      'age': age,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      profilePicUrl: json['profilePicUrl'],
      realName: json['realName'],
      nric: json['nric'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      gender: json['gender'],
    );
  }
}

class UserCredentials {
  UserCredentials._privateConstructor();

  static final UserCredentials _instance =
      UserCredentials._privateConstructor();

  factory UserCredentials() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveToFirestore(User user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .set(user, SetOptions(merge: true));
      print('User data saved to Firestore: ${user.toJson()}');
    } catch (e) {
      print('Error saving user to Firestore: $e');
      throw e;
    }
  }

  Future<User?> loadFromFirestore() async {
    try {
      final uid = auth.FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        print('User not logged in');
        return null; // User not logged in
      }
      final doc = await _firestore
          .collection('users')
          .doc(uid)
          .withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          )
          .get();

      if (doc.exists) {
        print('User data loaded from Firestore: ${doc.data()!.toJson()}');
        return doc.data();
      } else {
        print('User document not found');
        return null; // Document not found
      }
    } catch (e) {
      print('Error loading user from Firestore: $e');
      throw e;
    }
  }
}
