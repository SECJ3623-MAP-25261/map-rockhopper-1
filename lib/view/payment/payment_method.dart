import 'package:flutter/material.dart';
import '../settings/settings.dart';



void main() {
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment UI',
      home: const PaymentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
    title: const Text('Payment Method'),
    backgroundColor: Colors.pink,
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
      ),
    ],
  ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              
      
            ),
            const SizedBox(height: 20),

            // Payment options
            paymentOption('Credit Card', Icons.credit_card),
            paymentOption('PayPal', Icons.account_balance_wallet),
            paymentOption('Google Pay', Icons.payment),
            paymentOption('Apple Pay', Icons.phone_iphone),

            const SizedBox(height: 10),

            // Pay button'
            Padding(
  padding: EdgeInsets.only(left: 50, top: 20),
           child: SizedBox(
              width: 900,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Paying with $selectedMethod')),
                  );
                },
                child: const Text('Pay Now', style: TextStyle(fontSize: 18)),
              ),
            ),
            )
           
          ],
        ),
      ),
    );
  }

  Widget paymentOption(String method, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: RadioListTile(
        value: method,
        groupValue: selectedMethod,
        onChanged: (String? value) {
          setState(() {
            selectedMethod = value!;
          });
        },
        title: Text(method),
        secondary: Icon(icon),
      ),
    );
  }
}