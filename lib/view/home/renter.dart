import 'package:flutter/material.dart';
import '../home/home_roles/role_switch_bottom_sheet.dart';
import '../home/home_roles/renter_home.dart';
import '../home/home_roles/rentee_home.dart';
import '../cart/renting_cart.dart';
import '../profile/renter_profile.dart';
import '../home/home_roles/role_navbar.dart';
import '../updates/notifications_screen.dart';
import '../home/rentee.dart';    // important

class RenterMain extends StatefulWidget {
  const RenterMain({super.key});

  @override
  State<RenterMain> createState() => _RenterMainState();
}

class _RenterMainState extends State<RenterMain> {
  int currentIndex = 0;

  final pages = const [
    RenterHome(),
    RentingCartScreen(),
    NotificationsScreen(cartItems: []),
    RenterProfile(),
  ];

   void _switchToRentee() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RenteeHome(),
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
        currentRole: "renter",
        onRoleSwitch: _switchToRentee,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), // Your 4th item
            label: "Updates",
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
