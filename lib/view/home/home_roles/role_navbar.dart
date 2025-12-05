import 'package:flutter/material.dart';
import 'role_switch_bottom_sheet.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String currentRole; // "rentee" or "renter"
  final VoidCallback onRoleSwitch; // callback to switch role
  final List<BottomNavigationBarItem> items; // Dynamic items

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.currentRole,
    required this.onRoleSwitch,
    required this.items, // Now required
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => RoleSwitchBottomSheet(
            currentRole: currentRole,
            onSwitchRole: (newRole) {
              if (newRole != currentRole) {
                onRoleSwitch();
              }
            },
          ),
        );
      },
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        type: BottomNavigationBarType.fixed, // Important for 4+ items
      ),
    );
  }
}