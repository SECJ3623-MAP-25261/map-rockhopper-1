import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Renter {
  final String id;
  final String fullName;
  final String profilePhotoUrl;
  final String bio;
  final String occupation;
  final int? age;
  final List<String> languages;
  final DateTime joinedDate;
  final double rating;
  final int totalReviews;
  final List<String> rentalHistory;
  final String phoneNumber;

  Renter({
    required this.id,
    required this.fullName,
    required this.profilePhotoUrl,
    required this.bio,
    required this.occupation,
    this.age,
    required this.languages,
    required this.joinedDate,
    required this.rating,
    required this.totalReviews,
    required this.rentalHistory,
    required this.phoneNumber,
  });
}

class RenterProfilePopup extends StatelessWidget {
  final Renter user;

  const RenterProfilePopup({Key? key, required this.user}) : super(key: key);

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
                // Profile header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(user.profilePhotoUrl),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Renter (Tenant)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.purple,
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

                // Personal info section
                _buildInfoSection(
                  title: 'Personal Information',
                  children: [
                    if (user.age != null)
                      _buildInfoRow(
                        icon: Icons.person_outline,
                        label: 'Age',
                        value: '${user.age} years',
                      ),
                    _buildInfoRow(
                      icon: Icons.work_outline,
                      label: 'Occupation',
                      value: user.occupation,
                    ),
                    _buildInfoRow(
                      icon: Icons.language_outlined,
                      label: 'Languages',
                      value: user.languages.join(', '),
                    ),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Joined',
                      value: DateFormat('MMMM yyyy').format(user.joinedDate),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Rating section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amber.shade100),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.rating.toString(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'from ${user.totalReviews} hosts',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rating from Rentees',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Rental history
                _buildRentalHistory(),

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

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children
                .map((child) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: child,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
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
        ),
      ],
    );
  }

  Widget _buildRentalHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Rental History',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user.rentalHistory.isEmpty)
                Text(
                  'No rental history yet',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                )
              else
                ...user.rentalHistory.take(3).map((rental) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4, right: 12),
                          child: Icon(
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            rental,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              if (user.rentalHistory.length > 3)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'and ${user.rentalHistory.length - 3} more...',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
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
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle block action
              },
              child: const Text(
                'Block User',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 16,
              width: 1,
              color: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle report action
              },
              child: const Text(
                'Report',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Example usage in your app:
/*
RenterProfilePopup(
  user: Renter(
    id: '1',
    fullName: 'Michael Chen',
    profilePhotoUrl: 'https://example.com/photo.jpg',
    bio: 'Exchange student from China. Clean and responsible tenant.',
    occupation: 'Student',
    age: 24,
    languages: ['English', 'Mandarin', 'Malay'],
    joinedDate: DateTime(2023, 5, 10),
    rating: 4.5,
    totalReviews: 20,
    rentalHistory: [
      'Rented Room A - Skudai',
      'Rented Studio - Kuala Lumpur',
      'Rented Apartment - Penang',
    ],
    phoneNumber: '+60123456789',
  ),
)
*/