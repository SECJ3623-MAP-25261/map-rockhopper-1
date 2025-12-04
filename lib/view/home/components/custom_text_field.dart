import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}