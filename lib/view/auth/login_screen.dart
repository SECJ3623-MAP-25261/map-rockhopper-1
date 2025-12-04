import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';
import 'forgot_password.dart';
import 'forgot_email.dart';
//import '../home/home_roles/renter_home.dart';
import '../home/preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WELCOME BACK at top center
              const Center(
                child: Text(
                  'WELCOME BACK',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Email or Username Field
              const Text(
                'email or username',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration:  InputDecoration(
                  hintText: 'Enter your email or username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Continue with code box
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      _showSnackBar('Please enter your email first');
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OTPVerificationScreen(email: email),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Continue with code',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              const Text(
                'password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration:  InputDecoration(
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Forgot password & Forgot email (clickable)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      print('Forgot password pressed');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      print('Forgot email pressed');
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotEmailScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot email?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // DONE button at bottom right
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _loginUser();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PreferencesScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    // Simulate login process
    print('Logging in with: $email');
    _showSnackBar('Login successful!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}