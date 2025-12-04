/*import 'package:flutter/material.dart';
import '../home/home_roles/rentee_home.dart';
import '../home/home_roles/renter_home.dart';
//import '../listings/createlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String currentRole = 'rentee';

  final Map<String, Map<String, dynamic>> roleData = {
    'rentee': {'name': 'Rentee', 'color': Colors.green},
    'renter': {'name': 'Renter', 'color': Colors.blue},
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      currentRole == "rentee" ? const RenteeHome() : const RenterHome(),
      const CreateList(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: "Add List"),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (context) => RoleSwitchBottomSheet(
                    currentRole: currentRole,
                    roleData: roleData,
                    onSwitchRole: (newRole) {
                      setState(() {
                        currentRole = newRole;
                        currentIndex = 0;
                      });
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Icon(Icons.person),
            ),
            label: "Profile",
          ),
        ],
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
      ),
    );
  }
}

class RoleSwitchBottomSheet extends StatelessWidget {
  final String currentRole;
  final Map<String, Map<String, dynamic>> roleData;
  final Function(String) onSwitchRole;

  const RoleSwitchBottomSheet({
    super.key,
    required this.currentRole,
    required this.roleData,
    required this.onSwitchRole,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Switch Role", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...roleData.keys.map((role) {
            final isSelected = currentRole == role;
            return ListTile(
              leading: Icon(
                role == 'rentee' ? Icons.shopping_bag : Icons.person_search,
                color: roleData[role]!['color'],
              ),
              title: Text(
                roleData[role]!['name'],
                style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              ),
              subtitle: Text(role == 'rentee' ? 'Find items to rent' : 'Manage your rentals', style: const TextStyle(fontSize: 12)),
              trailing: isSelected ? Icon(Icons.check_circle, color: roleData[role]!['color']) : null,
              onTap: () => onSwitchRole(role),
            );
          }).toList(),
        ],
      ),
    );
  }
}

// Dummy pages
class CreateList extends StatelessWidget {
  const CreateList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Create New Listing Page", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),

    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Profile Page", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
    );
  }
}
*/