import 'package:flutter/material.dart';

void main() {
  runApp(const PinjamTechApp());
}

class PinjamTechApp extends StatelessWidget {
  const PinjamTechApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PinjamTech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}