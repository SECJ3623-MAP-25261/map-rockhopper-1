import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'view/home/home_roles/rentee_home.dart';
import 'view/home/home_roles/renter_home.dart';
import 'view/auth/welcome_screen.dart';



//const supabaseUrl = 'https://moaqfxollzcqizdbquvy.supabase.co';
//const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vYXFmeG9sbHpjcWl6ZGJxdXZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5MDgyMDQsImV4cCI6MjA4MDQ4NDIwNH0.LGAgzASzGXXeNtNQ___yH9JscUeVnmxi7SSbFJlsucQ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://moaqfxollzcqizdbquvy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1vYXFmeG9sbHpjcWl6ZGJxdXZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ5MDgyMDQsImV4cCI6MjA4MDQ4NDIwNH0.LGAgzASzGXXeNtNQ___yH9JscUeVnmxi7SSbFJlsucQ',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PinjamTech",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomeScreen(),
    );
  }
}
