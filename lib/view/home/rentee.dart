//rentee.dart
import 'package:flutter/material.dart';
import '../home/home_roles/role_switch_bottom_sheet.dart';
import '../home/home_roles/rentee_home.dart';
import '../profile/rentee_profile.dart';
import '../home/rentee.dart';   // make sure this file contains class RenterMain
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          const BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Create"),

          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => RoleSwitchBottomSheet(
                    currentRole: "rentee",
                    onSwitchRole: (newRole) {
                      if (newRole == "renter") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RenterMain(),
                          ),
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