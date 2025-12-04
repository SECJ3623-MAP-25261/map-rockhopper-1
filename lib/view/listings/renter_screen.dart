/*import 'package:flutter/material.dart';
import '../home/home_roles/role_switch_bottom_sheet.dart'; // import your role switch sheet

class RenterScreen extends StatefulWidget {
  const RenterScreen({Key? key}) : super(key: key);

  @override
  State<RenterScreen> createState() => _RenterScreenState();
}

class _RenterScreenState extends State<RenterScreen> {
  String _currentRole = 'renter'; // Default role is RENTER (borrower)

  final Map<String, Map<String, dynamic>> _roleData = {
    'renter': {
      'name': 'Renter', // Borrower - rents items
      'email': 'user@pinjamtech.com',
      'color': Colors.blue,
    },
    'rentee': {
      'name': 'Rentee', // Lender - rents out items
      'email': 'user@pinjamtech.com',
      'color': Colors.green,
    },
  };

  void _switchRole(String newRole) {
    setState(() {
      _currentRole = newRole;
    });
    Navigator.of(context).pop();
  }

  void _showRoleSwitchSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return RoleSwitchBottomSheet(
          currentRole: _currentRole,
          roleData: _roleData,
          onSwitchRole: _switchRole,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _currentRole == 'renter' ? 'Renter Dashboard' : 'Rentee Dashboard',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Implement notifications
            },
          ),
        ],
      ),
      body: _buildContent(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simple welcome message based on role
          Text(
            _currentRole == 'renter' 
                ? 'Find Items to Rent'
                : 'Manage Your Items',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currentRole == 'renter'
                ? 'Browse and rent items from others'
                : 'List your items and manage rentals',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),

          // Role-specific simple content
          if (_currentRole == 'renter') _buildRenterContent(), // Borrower sees available items
          if (_currentRole == 'rentee') _buildRenteeContent(), // Lender sees their listed items
        ],
      ),
    );
  }

  Widget _buildRenterContent() {
    return Expanded(
      child: Column(
        children: [
          // Quick stats for renter (borrower)
          Row(
            children: [
              _buildStatCard('Items Rented', '8', Colors.blue),
              const SizedBox(width: 12),
              _buildStatCard('Wishlist', '3', Colors.orange),
            ],
          ),
          const SizedBox(height: 24),
          
          // Browse items button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Browse items functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Browse Items',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRenteeContent() {
    return Expanded(
      child: Column(
        children: [
          // Quick stats for rentee (lender)
          Row(
            children: [
              _buildStatCard('Items Listed', '5', Colors.green),
              const SizedBox(width: 12),
              _buildStatCard('Active Rentals', '3', Colors.blue),
            ],
          ),
          const SizedBox(height: 24),
          
          // Add item button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Add item functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Add New Item',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _buildBottomNavigationBar() {
  return SizedBox(
    height: 80,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Background bar
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Left group
                _buildNavIcon(Icons.home),
                _buildNavIcon(Icons.search),

                const SizedBox(width: 60), // space for center button

                // Right group
                _buildNavIcon(Icons.notifications),
                _buildProfileNavItemIcon(),
              ],
            ),
          ),
        ),

        // Center large button
        Positioned(
          bottom: 10,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _roleData[_currentRole]!['color'],
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.white, size: 32),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNavIcon(IconData icon) {
  return Icon(icon, color: Colors.grey, size: 26);
}

Widget _buildProfileNavItemIcon() {
  return GestureDetector(
    onLongPress: _showRoleSwitchSheet,
    child: CircleAvatar(
      radius: 15,
      backgroundColor: _roleData[_currentRole]!['color'],
      child: Text(
        _currentRole == 'renter' ? 'R' : 'E',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
}
*/