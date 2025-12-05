import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Rentee {
  final String id;
  final String fullName;
  final String profilePhotoUrl;
  final bool isVerified;
  final String bio;
  final double rating;
  final int totalReviews;
  final String responseTime;
  final String location;
  final List<String> availableRooms;
  final List<String> houseRules;
  final DateTime joinedDate;
  final String phoneNumber;

  Rentee({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
    required this.isVerified,
    required this.bio,
    required this.rating,
    required this.totalReviews,
    required this.responseTime,
    required this.location,
    required this.availableRooms,
    required this.houseRules,
    required this.joinedDate,
    required this.phoneNumber,
  });
}

class RenteeProfilePopup extends StatelessWidget {
  final Rentee user;
  
  const RenteeProfilePopup({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      insetPadding: const EdgeInsets.all(20.0),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with avatar and name
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.profilePhotoUrl),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (user.isVerified)
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Rentee (Owner)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Bio section
                if (user.bio.isNotEmpty) ...[
                  Text(
                    user.bio,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Stats section
                _buildStatsSection(),
                
                const SizedBox(height: 24),
                
                // Location section
                _buildInfoSection(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  value: user.location,
                ),
                
                const SizedBox(height: 20),
                
                // Available rooms
                _buildAvailableRooms(),
                
                const SizedBox(height: 20),
                
                // House rules
                _buildHouseRules(),
                
                const SizedBox(height: 20),
                
                // Joined date
                _buildInfoSection(
                  icon: Icons.calendar_today_outlined,
                  title: 'Joined',
                  value: DateFormat('MMMM yyyy').format(user.joinedDate),
                ),
                
                const SizedBox(height: 32),
                
                // Action buttons
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    user.rating.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'from ${user.totalReviews} renters',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade300,
          ),
          Column(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(height: 4),
              Text(
                user.responseTime,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'response time',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableRooms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Rooms',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: user.availableRooms.map((room) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.king_bed_outlined,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    room,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHouseRules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'House Rules',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: user.houseRules.map((rule) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4, right: 8),
                    child: Icon(
                      Icons.circle,
                      size: 6,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rule,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle message action
                },
                icon: const Icon(Icons.message_outlined, size: 20),
                label: const Text('Message'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle call action
                },
                icon: const Icon(Icons.phone_outlined, size: 20),
                label: const Text('Call'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade50,
                  foregroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.green.shade200),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // Handle report action
          },
          child: const Text(
            'Report User',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

// Example usage in your app:
/*
RenteeProfilePopup(
  user: Rentee(
    id: '1',
    fullName: 'Alex Johnson',
    profilePhotoUrl: 'https://example.com/photo.jpg',
    isVerified: true,
    bio: 'Professional host with 5+ years experience. Love meeting new people!',
    rating: 4.8,
    totalReviews: 120,
    responseTime: 'Within 1 hour',
    location: 'New York City',
    availableRooms: ['Single Room', 'Double Room', 'Studio'],
    houseRules: [
      'No smoking inside',
      'No pets allowed',
      'Check-in after 2 PM',
      'Quiet hours 10 PM - 7 AM',
    ],
    joinedDate: DateTime(2022, 3, 15),
    phoneNumber: '+1234567890',
  ),
)
*/