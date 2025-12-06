import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final VoidCallback? onProfileUpdated;

  const EditProfile({
    super.key,
    this.initialData,
    this.onProfileUpdated,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late String _selectedGender;
  bool _isLoading = false;

  final SupabaseClient _supabase = Supabase.instance.client;
  final List<String> _genders = ['Male', 'Female', 'Other', 'Prefer not to say'];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: widget.initialData?['full_name']?.toString() ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initialData?['phone']?.toString() ?? '',
    );
    _bioController = TextEditingController(
      text: widget.initialData?['bio']?.toString() ?? '',
    );
    _selectedGender = widget.initialData?['gender']?.toString() ?? 'Prefer not to say';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception('User not authenticated');

      final updates = <String, dynamic>{
        'full_name': _fullNameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'gender': _selectedGender,
        'bio': _bioController.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Remove empty fields
      updates.removeWhere((key, value) => value.toString().isEmpty);

      // Update profiles table
      await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', user.id);

      // Update auth metadata
      await _supabase.auth.updateUser(
        UserAttributes(
          data: {
            'full_name': _fullNameController.text.trim(),
            'phone': _phoneController.text.trim(),
          },
        ),
      );

      if (mounted) {
        _showSuccess('Profile updated successfully');
        widget.onProfileUpdated?.call();
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        _showError('Error: ${e.toString()}');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _uploadAvatar() async {
    // TODO: Implement image picker and upload to Supabase Storage
    _showInfo('Avatar upload coming soon!');
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _supabase.auth.currentUser;
    final role = widget.initialData?['role']?.toString() ?? 'renter';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(
                  onPressed: _updateProfile,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueGrey[100],
                      backgroundImage: widget.initialData?['avatar_url'] != null
                          ? NetworkImage(widget.initialData!['avatar_url'].toString())
                          : null,
                      child: widget.initialData?['avatar_url'] == null
                          ? const Icon(Icons.person, size: 60, color: Colors.blueGrey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _uploadAvatar,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Full Name
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone_outlined, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              // Gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.transgender, color: Colors.blueGrey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: _genders.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedGender = value);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bio
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.description_outlined, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Account Information (Read-only)
              const Text(
                'Account Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Email (Read-only)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined, color: Colors.blueGrey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'Not available',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Role (Read-only)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.badge_outlined, color: Colors.blueGrey),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Role',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            role.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
}