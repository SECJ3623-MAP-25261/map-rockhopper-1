import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onPressed; // callback function

  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: section name and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          // Right side: Edit button
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
