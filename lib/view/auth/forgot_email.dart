import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';

class ForgotEmailScreen extends StatefulWidget {
  const ForgotEmailScreen({super.key});

  @override
  State<ForgotEmailScreen> createState() => _ForgotEmailScreenState();
}

class _ForgotEmailScreenState extends State<ForgotEmailScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      _showSnackBar('Please enter your phone number');
      return;
    }

    // TODO: You can connect Firebase Phone Auth later
    _showSnackBar('Verification code sent!');
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPVerificationScreen(email: phone),
      ),
    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Email',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phone Number',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
