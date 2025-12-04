// user_model.dart
class UserProfile {
  String firstName;
  String lastName;
  String username;
  String email;
  String phone;
  String gender;
  String bio; // new bio field

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.gender,
    this.bio = '', // default empty
  });

  // Optional: convenience method to get full name
  String get fullName => '$firstName $lastName';

  // Optional: copyWith method for easy updating
  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? gender,
    String? bio,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      bio: bio ?? this.bio,
    );
  }
}
