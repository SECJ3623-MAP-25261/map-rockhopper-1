import 'package:flutter/material.dart';
import '../listings/order_listing.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Successful')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Your renting transaction was successful!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderListing(
                        orders: const [],   // placeholder list
          initialIndex: 0,
                      )),
                );
              },
              child: const Text('Go to My Orders'),
            ),
          ],
        ),
      ),
    );
  }
}