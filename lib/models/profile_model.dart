import 'order_model.dart';

class ProfileModel {
  final String id;
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

  final int followersCount;
  final int followingCount;

  final DateTime joinDate;

  final List<Order> recentOrders; // <-- synced with OrderListing

  ProfileModel({
    required this.id,
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
    required this.isOwnProfile,
    required this.followersCount,
    required this.followingCount,
    required this.joinDate,
    required this.recentOrders,
  });

  String get name => "$firstName $lastName";
}
