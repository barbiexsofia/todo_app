import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_services.dart';

class SignupScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text("Register here",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white60),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.white60)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white60),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.white60)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
