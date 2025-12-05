//rentee.dart
import 'package:flutter/material.dart';
import '../home/home_roles/role_switch_bottom_sheet.dart';
import '../home/home_roles/rentee_home.dart';
import '../home/home_roles/role_navbar.dart';
import '../profile/rentee_profile.dart';
import '../listings/createlist.dart';
import '../home/renter.dart';    // important

class RenteeMain extends StatefulWidget {
  const RenteeMain({super.key});

  @override
  State<RenteeMain> createState() => _RenteeMainState();
}

class _RenteeMainState extends State<RenteeMain> {
  int currentIndex = 0;
  
  final pages = const [
    RenteeHome(),
    CreateList(),
    RenteeProfile(),
  ];

  void _switchToRenter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RenterMain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        currentRole: "rentee",
        onRoleSwitch: _switchToRenter,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}