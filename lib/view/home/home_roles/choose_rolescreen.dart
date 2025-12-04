import 'package:flutter/material.dart';
import 'rentee_home.dart';
import '../rentee.dart';
import '../renter.dart';


class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Do you want to be a rentee or renter?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

         ElevatedButton(
  onPressed: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => RenteeMain()),
    );
  },
  child: const Text("Rentee"),
),

const SizedBox(height: 20),

ElevatedButton(
  onPressed: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => RenterMain()),
    );
  },
  child: const Text("Renter"),
),

          ],
        ),
      ),
    );
  }
}

