import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '/models/user.dart' as model;
import '../ui/home.dart';
import '../ui/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // Create user account
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Send email verification
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(
          msg: 'Verification email sent! Please check your inbox.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }

      // Show alert to inform user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Verify Your Email'),
          content: const Text(
              'A verification email has been sent to your email. Please verify before logging in.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter both email and password.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'The password you entered is incorrect. Please try again.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signout({required BuildContext context}) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
    );
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, get the UserCredential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? firebaseUser = userCredential.user;

      // Create and return a custom User object
      if (firebaseUser != null) {
        // Store user details in the UserCredentials singleton instance
        model.UserCredentials().email = firebaseUser.email ?? '';
        model.UserCredentials().uid = firebaseUser.uid;
        model.UserCredentials().displayName = firebaseUser.displayName ?? '';
        model.UserCredentials().profilePicUrl = firebaseUser.photoURL ?? '';

        // Save user details to shared preferences
        await model.UserCredentials().saveToPreferences();

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePage()),
        );
      } else {
        throw Exception('Failed to sign in with Google');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'An error occurred. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
