import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _emailController = TextEditingController();
  final auth = AuthService();

  void handleSendOtp() async {
    await auth.sendOtp(_emailController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Check your email for the login link")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _emailController),
          ElevatedButton(
            onPressed: handleSendOtp,
            child: Text("Send OTP"),
          ),
        ],
      ),
    );
  }
}
