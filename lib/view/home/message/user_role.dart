import 'package:flutter/material.dart';

String currentRole = 'Renter'; // Default role

void showRoleSelectionPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Role'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                currentRole = 'Renter';
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Role changed to Renter')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Renter'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                currentRole = 'Rentee';
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Role changed to Rentee')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Rentee'),
            ),
          ],
        ),
      );
    },
  );
}