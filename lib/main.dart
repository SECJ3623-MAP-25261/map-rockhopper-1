import 'package:flutter/material.dart';
import 'view/home/home_roles/rentee_home.dart';
import 'view/home/home_roles/renter_home.dart';
import 'view/auth/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

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

