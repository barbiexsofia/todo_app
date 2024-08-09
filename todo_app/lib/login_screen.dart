import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_services.dart';
import 'package:todo_app/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _databaseError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: const Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Text("Welcome back",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
              const SizedBox(height: 5),
              const Text("Log in here",
                  style: TextStyle(
                    fontSize: 16,
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
                  labelStyle: const TextStyle(color: Colors.white60),
                  errorText: _emailError, // Display error text if any
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                obscureText: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white60),
                  errorText: _passwordError, // Display error text if any
                ),
              ),
              const SizedBox(height: 20.0),
              _databaseError != null
                  ? Text(
                      _databaseError!,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                  onPressed: () {
                    _auth.validateAndSubmit(
                      isLogin: true,
                      context: context,
                      emailController: _emailController,
                      passController: _passController,
                      setEmailError: (error) {
                        setState(() {
                          _emailError = error;
                        });
                      },
                      setPasswordError: (error) {
                        setState(() {
                          _passwordError = error;
                        });
                      },
                      setDatabaseError: (error) {
                        setState(() {
                          _databaseError = error;
                        });
                      },
                    );
                  },
                  child: const Text(
                    "Log in",
                    style: (TextStyle(
                      color: Colors.indigo,
                      fontSize: 18,
                    )),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "OR",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ));
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
