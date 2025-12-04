import 'package:flutter/material.dart';
import '../profile/edit_profile.dart';
import '../home/home_roles/choose_rolescreen.dart';

class PreferenceFilteredScreen extends StatelessWidget {
  final List<String> selectedItems;

  const PreferenceFilteredScreen({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.network(
                "https://i.imgur.com/UA2fhxC.png",
                height: 180,
              ),

              const SizedBox(height: 30),

              const Text(
                "That's cool! Now we will filter your preferences\nonto your timeline!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const Text(
                "Heyy, your timeline will be updated\naccordingly when you rent or make item.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: selectedItems.map((e) {
                  return Chip(
                    label: Text(e),
                    backgroundColor: Colors.pink.shade100,
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: 
                      (_) => ChooseRoleScreen() )
                      );
                    },
                    child: const Text("Can I go now?"),
                  ),
                 ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfile(),
      ),
    );
  },
  child: const Text("I want to update profile"),
),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
