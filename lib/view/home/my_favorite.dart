import 'package:flutter/material.dart';

class MyFavourite extends StatelessWidget {
  const MyFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.pink, // optional
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Add navigation to Edit Profile page
                print('Edit Profile tapped');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                print('Change Password tapped');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                print('Notification Settings tapped');
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}