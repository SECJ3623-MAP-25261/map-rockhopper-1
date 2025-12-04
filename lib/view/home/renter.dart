import 'package:flutter/material.dart';
import '../home/home_roles/role_switch_bottom_sheet.dart';
import '../home/home_roles/renter_home.dart';
import '../cart/renting_cart.dart';
import '../profile/renter_profile.dart';
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
    RenteeProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Updates"),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Updates"),

          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RoleSwitchBottomSheet(
                    currentRole: "renter",
                    onSwitchRole: (newRole) {
                      if (newRole == "rentee") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const RenteeMain()),
                        );
                      }
                    },
                  ),
                );
              },
              child: const Icon(Icons.person),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
