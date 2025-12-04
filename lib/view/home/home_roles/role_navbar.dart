/*import 'package:flutter/material.dart';

class RoleBottomNavigationBar extends StatelessWidget {
  final String currentRole;
  final Map<String, Map<String, dynamic>> roleData;

  const RoleBottomNavigationBar({
    Key? key,
    required this.currentRole,
    required this.roleData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: roleData[currentRole]!['color'],
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Browse',
        ),
        BottomNavigationBarItem( 
          icon: Badge.count(
            count: 3,
            child: const Icon(Icons.notifications),
          ),
          label: 'Notifications',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // TODO: Handle navigation
      },
    );
  }
}
*/
