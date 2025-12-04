import 'package:flutter/material.dart';
import 'dart:async';
import 'payment_success.dart';

class MakePaymentScreen extends StatefulWidget {
  final double totalPrice;
  const MakePaymentScreen({super.key, required this.totalPrice});

  @override
  State<MakePaymentScreen> createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate payment delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentSuccessScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing Payment')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Payment is being processed...'),
          ],
        ),
      ),
    );
  }
}