import 'package:flutter/material.dart';
import 'user_model.dart'; // Make sure you have UserProfile class

class EditProfile extends StatelessWidget {
  final UserProfile? user; // pass current user profile

  const EditProfile({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with existing values if available
    
    final firstNameController = TextEditingController(text: user?.firstName ?? '');
    final lastNameController = TextEditingController(text: user?.lastName ?? '');
    final usernameController = TextEditingController(text: user?.username ?? '');
    final emailController = TextEditingController(text: user?.email ?? '');
    final phoneController = TextEditingController(text: user?.phone ?? '');
    final genderController = TextEditingController(text: user?.gender ?? '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: firstNameController,
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    controller: lastNameController,
                    labelText: 'Last Name',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(controller: usernameController, labelText: 'Username'),
            const SizedBox(height: 16),
            CustomTextField(controller: emailController, labelText: 'Email'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(controller: genderController, labelText: 'Gender'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(controller: phoneController, labelText: 'Phone'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Create updated UserProfile
                  final updatedUser = UserProfile(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    username: usernameController.text,
                    email: emailController.text,
                    gender: genderController.text,
                    phone: phoneController.text,
                  );

                  // Show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated!')),
                  );

                  // Return updated user to previous page
                  Navigator.pop(context, updatedUser);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
