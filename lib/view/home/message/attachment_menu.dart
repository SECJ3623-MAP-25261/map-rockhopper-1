import 'package:flutter/material.dart';

class AttachmentMenu extends StatelessWidget {
  final Function(String) onAttachmentSelected;
  
  const AttachmentMenu({super.key, required this.onAttachmentSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: GridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _MenuItem(
            icon: Icons.photo_library,
            label: "Photos",
            color: Colors.green,
            onTap: () => onAttachmentSelected("Photo"),
          ),
          _MenuItem(
            icon: Icons.camera_alt,
            label: "Camera",
            color: Colors.blue,
            onTap: () => onAttachmentSelected("Camera"),
          ),
          _MenuItem(
            icon: Icons.insert_drive_file,
            label: "Document",
            color: Colors.orange,
            onTap: () => onAttachmentSelected("Document"),
          ),
          _MenuItem(
            icon: Icons.location_on,
            label: "Location",
            color: Colors.red,
            onTap: () => onAttachmentSelected("Location"),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}