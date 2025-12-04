import 'package:flutter/material.dart';
import '../../models/profile_model.dart';
import '../../view/settings/settings.dart';

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
      username: 'jaafar123',
      email: 'jaafar@example.com',
      gender: 'Male',
      phone: '0123456789',
      bio:
          'Tech enthusiast and laptop lover! I enjoy trying out different devices for work and gaming.',
      avatarUrl: null,
      rating: 4.7,
      totalRentals: 24,
      isOwnProfile: true,
      followersCount: 150,
      followingCount: 89,
      joinDate: DateTime(2023, 3, 15),
      recentOrders: [],
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.8),
                      Colors.blue.withOpacity(0.3),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    _buildProfileHeader(),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatistics(),
                  const SizedBox(height: 20),
                  _buildBioSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            color: Colors.grey[300],
          ),
          child: user.avatarUrl != null
              ? ClipOval(
                  child: Image.network(
                    user.avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.person, size: 50, color: Colors.white);
                    },
                  ),
                )
              : const Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 16),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Rentee',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Member since ${_formatDate(user.joinDate)}',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  Widget _buildStatistics() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.analytics, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Rental Statistics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildStatCard('Total Orders', user.recentOrders.length.toString(),
                  Icons.shopping_bag),
              _buildStatCard(
                  'Followers', user.followersCount.toString(), Icons.people),
              _buildStatCard(
                  'Following', user.followingCount.toString(), Icons.person_add),
              _buildStatCard('Active Rentals', '2', Icons.laptop),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.description, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'About Me',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            user.bio ?? 'No bio added yet',
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
