import 'package:flutter/material.dart';
import 'preferencefilter.dart ';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final List<String> suggestions = [
    "Laptop", "Mouse", "Projector", "Microphone", "Monitor",
    "LED", "HDMI cable", "Breadboard", "Soldering iron",
    "Powerbank", "VR box", "Cooling fan"
  ];

  final List<String> selected = [];
  final TextEditingController customController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Cute character image
              Center(
                child: Image.network(
                  "https://i.imgur.com/QEYSdNk.png",
                  height: 150,
                ),
              ),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "What do you like to rent?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 25),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search your preferred renting stuff",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: suggestions.map((item) {
                  final isSelected = selected.contains(item);
                  return ChoiceChip(
                    label: Text(item),
                    selected: isSelected,
                    selectedColor: Colors.pink.shade100,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          selected.add(item);
                        } else {
                          selected.remove(item);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Add your own
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: customController,
                      decoration: InputDecoration(
                        hintText: "Add your own",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (customController.text.trim().isNotEmpty) {
                        setState(() {
                          selected.add(customController.text.trim());
                        });
                        customController.clear();
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PreferenceFilteredScreen(selectedItems: selected),
                      ),
                    );
                  },
                  child: const Text("Think Later"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
