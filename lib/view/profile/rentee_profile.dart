import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../view/settings/settings.dart';

class RenteeProfile extends StatefulWidget {
  const RenteeProfile({super.key});

  @override
  State<RenteeProfile> createState() => _RenteeProfileState();
}

class _RenteeProfileState extends State<RenteeProfile> {
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        setState(() {
          _hasError = true;
          _errorMessage = 'User not logged in';
          _isLoading = false;
        });
        return;
      }

      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle()
          .timeout(const Duration(seconds: 10));

      print('Profile response: $response'); // Debug log

      setState(() {
        _profileData = response;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading profile: $e');
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 64),
              const SizedBox(height: 20),
              const Text(
                'Failed to load profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadProfileData,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Extract user data with proper fallbacks
    final user = _supabase.auth.currentUser;
    
    // Get data from BOTH sources with proper fallbacks
    final authName = user?.userMetadata?['full_name']?.toString();
    final profileName = _profileData?['full_name']?.toString();
    final displayName = profileName ?? authName ?? 'No Name';
    
    final email = user?.email ?? 'No email';
    
    final authPhone = user?.userMetadata?['phone']?.toString();
    final profilePhone = _profileData?['phone']?.toString();
    final displayPhone = profilePhone ?? authPhone ?? 'No phone';
    
    final gender = _profileData?['gender']?.toString() ?? 'Not specified';
    final bio = _profileData?['bio']?.toString() ?? 'No bio yet';
    final avatarUrl = _profileData?['avatar_url']?.toString();
    
    // Get role from profiles table
    final role = _profileData?['role']?.toString() ?? 'renter';
    
    // Parse join date
    DateTime joinDate;
    try {
      joinDate = DateTime.parse(_profileData?['created_at'] ?? DateTime.now().toIso8601String());
    } catch (e) {
      joinDate = DateTime.now();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              ).then((_) {
                _loadProfileData(); // Refresh when returning
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProfileData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProfileData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header with gradient
              Container(
                height: 280,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue.withOpacity(0.9),
                      Colors.blue.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile Picture with edit indicator
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          backgroundImage: avatarUrl != null && avatarUrl.isNotEmpty
                              ? NetworkImage(avatarUrl)
                              : null,
                          child: avatarUrl == null || avatarUrl.isEmpty
                              ? const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.blue,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Name
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    
                    // Role Badge
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        color: role == 'rentee' ? Colors.orange[700] : Colors.blue[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        role.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    // Email & Join Date
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Text(
                            email,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Member since ${_formatDate(joinDate)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Rating (if available)
                    if (_profileData?['rating'] != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '${_profileData!['rating']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              
              // Profile Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Information Card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.contact_phone, color: Colors.blue, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  'Contact Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            _buildContactRow(Icons.phone, 'Phone', displayPhone),
                            const SizedBox(height: 15),
                            _buildContactRow(Icons.person, 'Gender', gender),
                            const SizedBox(height: 15),
                            _buildContactRow(Icons.email, 'Email', email),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Bio Card
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.description, color: Colors.blue, size: 22),
                                SizedBox(width: 10),
                                Text(
                                  'About Me',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              bio,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 25),
                    
                    // Action Buttons
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.edit, size: 22),
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ),
                              ).then((_) {
                                _loadProfileData();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.inventory, size: 22),
                            label: const Text(
                              'My Listings',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              // TODO: Navigate to listings page
                              _showSnackbar('My Listings page coming soon!');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              side: const BorderSide(color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.history, size: 22),
                            label: const Text(
                              'Rental History',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              // TODO: Navigate to rental history
                              _showSnackbar('Rental History page coming soon!');
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              side: BorderSide(color: Colors.grey[700]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 22, color: Colors.blueGrey),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}