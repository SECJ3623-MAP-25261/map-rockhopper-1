import 'package:flutter/material.dart';
import '../payment/make_payment.dart';

class RentingCartScreen extends StatefulWidget {
  const RentingCartScreen({super.key});

  @override
  State<RentingCartScreen> createState() => _RentingCartScreenState();
}

class _RentingCartScreenState extends State<RentingCartScreen> {
  // Dummy cart items
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Acer Nitro V15',
      'price': 10,
      'duration': 'Up to 60 days',
      'description': 'Rarely used, powerful performance.',
      'image':
          'https://cdn.uc.assets.prezly.com/26bcc88a-0478-40a1-8f29-cf52ef86196c/nitro_v15_special_angle_2.png',
      'selected': false,
    },
    {
      'name': 'Lenovo Ideapad 3',
      'price': 8,
      'duration': 'Up to 60 days',
      'description': 'Lightweight and efficient.',
      'image':
          'https://cdn.nbplaza.com.my/img/p/5/2/4/9/3/52493-large_default.jpg',
      'selected': false,
    },
  ];

  double get totalPrice => cartItems
      .where((item) => item['selected'] == true)
      .fold(0, (sum, item) => sum + (item['price'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Renting Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Text(item['description']),
                    trailing: Checkbox(
                      value: item['selected'],
                      onChanged: (bool? value) {
                        setState(() {
                          item['selected'] = value ?? false;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: RM ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: totalPrice == 0
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MakePaymentScreen(totalPrice: totalPrice),
                            ),
                          );
                        },
                  child: const Text('Proceed to Payment'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}