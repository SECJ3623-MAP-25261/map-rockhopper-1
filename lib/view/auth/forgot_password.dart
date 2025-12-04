import 'package:flutter/material.dart';
import 'forgot_password_2.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetEmail() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showDialog("Please enter your email.");
      return;
    }

    // Since we are NOT using Firebase, we directly navigate to screen 2.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePasswordScreen2(),
      ),
    );
  }

  void _showDialog(String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Notification"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Forgot Password"),
              backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your email to receive a reset link.",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendResetEmail,
                child: const Text("Send Reset Link"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
