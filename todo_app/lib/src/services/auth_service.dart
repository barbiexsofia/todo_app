import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/views/home_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Sign up
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Validate and Submit method
  Future<void> validateAndSubmit({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passController,
    required bool isLogin, // true for login, false for register
    required void Function(String?) setEmailError,
    required void Function(String?) setPasswordError,
    required void Function(String?) setDatabaseError,
  }) async {
    String email = emailController.text.trim();
    String password = passController.text.trim();
    bool isValid = true;

    // Reset errors
    setEmailError(null);
    setPasswordError(null);

    // Validate email
    if (email.isEmpty) {
      setEmailError('Email cannot be empty');
      isValid = false;
    } else if (!email.contains('@')) {
      setEmailError('Invalid email address');
      isValid = false;
    }

    // Validate password
    if (password.isEmpty) {
      setPasswordError('Password cannot be empty');
      isValid = false;
    } else if (password.length < 6) {
      setPasswordError('Password must be at least 6 characters');
      isValid = false;
    }

    if (isValid) {
      dynamic result;
      if (isLogin) {
        result = await signInWithEmailAndPassword(email, password);
      } else {
        result = await registerWithEmailAndPassword(email, password);
      }

      if (result != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        setDatabaseError('Authentication failed. Please try again.');
      }
    }
  }
}
