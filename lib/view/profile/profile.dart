import 'package:flutter/material.dart';
import '../settings/settings.dart';
import '../home/my_favorite.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String gender;
  final String phone;
  final String? bio;
  final String? avatarUrl;
  final double? rating;
  final int? totalRentals;
  final bool isOwnProfile;

  const ProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.gender,
    required this.phone,
    this.bio,
    this.avatarUrl,
    this.rating,
    this.totalRentals,
    this.isOwnProfile = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: Text(
          isOwnProfile ? 'My Profile' : '$firstName $lastName',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: isOwnProfile
            ? [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 16),
            _buildStatsSection(),
            const SizedBox(height: 16),
            _buildBioSection(),
            const SizedBox(height: 16),
            _buildContactInfo(),
            const SizedBox(height: 16),
            if (isOwnProfile) _buildMenuSection(context),
            if (!isOwnProfile) _buildActionButtons(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey[100],
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                child: avatarUrl == null
                    ? Text(
                        '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      )
                    : null,
              ),
              if (isOwnProfile)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfile()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.edit, size: 16, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$firstName $lastName',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@$username',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          if (rating != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  rating!.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(totalRentals?.toString() ?? '0', 'Rentals'),
          Container(width: 1, height: 40, color: Colors.grey[200]),
          _buildStatItem(rating?.toStringAsFixed(1) ?? '0.0', 'Rating'),
          Container(width: 1, height: 40, color: Colors.grey[200]),
          _buildStatItem('Verified', 'Status'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bio ?? 'No bio added yet.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactRow(Icons.email_outlined, email),
          const SizedBox(height: 12),
          _buildContactRow(Icons.phone_outlined, phone),
          const SizedBox(height: 12),
          _buildContactRow(Icons.person_outline, gender),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.edit_outlined,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.favorite_outline,
            title: 'My Favorites',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyFavourite()),
              );
            },
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.history_outlined,
            title: 'Rental History',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.location_on_outlined,
            title: 'My Address',
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.blueGrey),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, color: Colors.grey[200], indent: 54);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Message'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('View Listings'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blueGrey,
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: const BorderSide(color: Colors.blueGrey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
