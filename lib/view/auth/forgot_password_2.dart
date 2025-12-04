import 'package:flutter/material.dart';

class ChangePasswordScreen2 extends StatelessWidget {
  const ChangePasswordScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Check Your Email")),
      body: Padding(
        
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We have sent a password reset link to your email.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            const Text(
              "Click the link in your email to create a new password.",
              style: TextStyle(fontSize: 16),
            ),

            const Spacer(),

            // Back to Login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Back to Login"),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
