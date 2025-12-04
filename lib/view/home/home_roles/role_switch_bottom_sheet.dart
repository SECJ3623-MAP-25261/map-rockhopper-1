import 'package:flutter/material.dart';

class RoleSwitchBottomSheet extends StatelessWidget {
  final String currentRole;
  final Function(String newRole) onSwitchRole;

  const RoleSwitchBottomSheet({
    super.key,
    required this.currentRole,
    required this.onSwitchRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Switch Role",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          _roleItem(context, "rentee", "Rentee", Icons.shopping_bag),
          _roleItem(context, "renter", "Renter", Icons.person_search),
        ],
      ),
    );
  }

  Widget _roleItem(BuildContext context, String role, String label, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label,
          style: TextStyle(
              fontWeight: currentRole == role ? FontWeight.bold : FontWeight.normal)),
      trailing: currentRole == role ? const Icon(Icons.check_circle) : null,
      onTap: () {
        onSwitchRole(role);
        Navigator.pop(context);
      },
    );
  }
}
