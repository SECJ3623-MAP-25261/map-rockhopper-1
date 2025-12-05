import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../view/settings/settings.dart';
import '../updates/notifications_screen.dart';
import '../auth/welcome_screen.dart';
import 'edit_profile.dart';
import '../profile/language/language.dart';

class RenteeProfile extends StatefulWidget {
  const RenteeProfile({super.key});

  @override
  State<RenteeProfile> createState() => _RenteeProfileState();
}

class _RenteeProfileState extends State<RenteeProfile> {
  late final ProfileModel user;

  @override
  void initState() {
    super.initState();
    user = ProfileModel(
      id: '1',
      firstName: 'Jaafar',
      lastName: 'Baba',
      username: 'Jaafar',
      email: 'jaafar@example.com',
      gender: 'Male',
      phone: '0123456789',
      bio: 'Tech enthusiast and laptop lover!',
      avatarUrl: null,
      rating: 4.7,
      totalRentals: 24,
      isOwnProfile: true,
      followersCount: 0,
      followingCount: 0,
      joinDate: DateTime(2023, 3, 15),
      recentOrders: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text('Profile'),
                actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _goToSettings,
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _goToHelp,
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMenuItem(
                  icon: Icons.notifications_outlined,
                  iconColor: Colors.blue,
                  title: 'Notifications',
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('0', style: TextStyle(fontSize: 14)),
                  ),
                  onTap: () {
                      Navigator.push(
                         context,
                             MaterialPageRoute(builder: (context) => NotificationsScreen(cartItems: [])),
                             );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.sell_rounded,
                  iconColor: Colors.blue,
                  title: 'My Listings',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.edit_outlined,
                  iconColor: Colors.blue,
                  title: 'Update Profile',
                  onTap: () {
                     Navigator.push(
                         context,
                             MaterialPageRoute(builder: (context) => EditProfile()),
                             );
                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.location_on_outlined,
                  iconColor: Colors.blue,
                  title: 'Location',
                  onTap: () {
                   /* Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LanguagePage()),
    );*/

                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.language,
                  iconColor: Colors.blue,
                  title: 'Language',
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.language,
                  iconColor: Colors.blue,
                  title: 'Ratings & Reviews',
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                _buildMenuItem(
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  title: 'Log Out',
                  onTap: _showLogoutDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue[100]!,
            Colors.teal[200]!,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(Icons.person, size: 40, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stores',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '#${user.followingCount}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Marks',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${user.followersCount}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
  onPressed: () {
    // Add logout logic here (e.g., Supabase sign out)
    // Example: await supabase.auth.signOut();

    // Navigate to WelcomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen()),
    );
  },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
    void _goToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  void _goToHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Help & Support')),
          body: const Center(child: Text('Help & Support Page')),
        ),
      ),
    );
  }
}