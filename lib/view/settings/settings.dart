// lib/view/settings/settings.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../profile/edit_profile.dart';
import '../payment/payment_method.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = false;
  bool darkModeEnabled = false;
  String selectedLanguage = 'English';
  
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

Future<void> _loadPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
    darkModeEnabled = prefs.getBool('dark_mode') ?? false;
    selectedLanguage = prefs.getString('language') ?? 'English';
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Settings Section
          _buildSectionTitle('Account Settings'),
          _buildSettingItem(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
          ),
          _buildSettingItem(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: _showChangePasswordDialog,
          ),
          _buildSettingItem(
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaymentApp()),
              );
            },
          ),

          const SizedBox(height: 24),

          // App Settings Section
          _buildSectionTitle('App Settings'),
          _buildSwitchSetting(
            icon: Icons.notifications,
            title: 'Notifications',
            value: notificationsEnabled,
            onChanged: (value) async {
              setState(() {
                notificationsEnabled = value;
              });
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('notifications_enabled', value);
              _showSnackbar('Notifications ${value ? 'enabled' : 'disabled'}');
            },
          ),
          _buildSwitchSetting(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
              _showSnackbar('Dark mode ${value ? 'enabled' : 'disabled'}');
            },
          ),
          _buildSettingItem(
            icon: Icons.language,
            title: 'Language',
            subtitle: selectedLanguage,
            onTap: _showLanguageDialog,
          ),

          const SizedBox(height: 24),

          // Support Section
          _buildSectionTitle('Support'),
          _buildSettingItem(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () {
              _showSnackbar('Help & support page coming soon!');
            },
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () {
              _showSnackbar('Privacy policy page coming soon!');
            },
          ),
          _buildSettingItem(
            icon: Icons.description,
            title: 'Terms of Service',
            onTap: () {
              _showSnackbar('Terms of service page coming soon!');
            },
          ),

          const SizedBox(height: 40),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _showLogoutConfirmation,
              child: const Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink),
        title: Text(title),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchSetting({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.pink),
        title: Text(title),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.pink,
        ),
      ),
    );
  }

  Future<void> _showChangePasswordDialog() async {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              if (newPasswordController.text != confirmPasswordController.text) {
                _showSnackbar('Passwords do not match!', isError: true);
                return;
              }

              if (newPasswordController.text.length < 6) {
                _showSnackbar('Password must be at least 6 characters!', isError: true);
                return;
              }

              try {
                await _supabase.auth.updateUser(
                  UserAttributes(password: newPasswordController.text),
                );
                
                if (mounted) {
                  Navigator.pop(context);
                  _showSnackbar('Password updated successfully!');
                }
              } catch (e) {
                _showSnackbar('Error: ${e.toString()}', isError: true);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    final languages = ['English', 'Bahasa Malaysia', '中文'];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((language) {
            return ListTile(
              title: Text(language),
              trailing: selectedLanguage == language
                  ? const Icon(Icons.check, color: Colors.pink)
                  : null,
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
                Navigator.pop(context);
                _showSnackbar('Language set to $language');
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
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
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              await _supabase.auth.signOut();
              if (mounted) {
                // Navigate to login screen
                Navigator.popUntil(context, (route) => route.isFirst);
                
                // If you have a specific login route, use this instead:
                // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.pink,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}