import 'package:flutter/material.dart';
import '../profile/edit_profile.dart' show EditProfile;
import '../payment/payment_method.dart';
import '../profile/user_model.dart'; // make sure you have UserProfile class

class SettingsPage extends StatefulWidget {
  final UserProfile? user; // optional, pass user to edit profile

  const SettingsPage({super.key, this.user});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Edit Profile
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () async {
                // Navigate to EditProfile and await updated data
                final updatedUser = await Navigator.push<UserProfile>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(user: widget.user),
                  ),
                );

                // Return updated data to previous page
                if (updatedUser != null) {
                  Navigator.pop(context, updatedUser);
                }
              },
            ),

            // Change Password (for example only)
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Implement your change password page if needed
              },
            ),

            // Payment Method
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Payment Method'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentApp()),
                );
              },
            ),

            const SizedBox(height: 20),
            const Text(
              'App Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Notification Switch
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),

            // Theme Switch
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Theme'),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),

            // Language
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to language page
              },
            ),

            const SizedBox(height: 20),

            // Logout Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
