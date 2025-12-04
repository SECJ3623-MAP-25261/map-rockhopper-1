/*
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EditListingWindows extends StatefulWidget {
  final String name;
  final String price;
  final bool available;
  final String duration;
  final String condition;
  final String description;
  final String category;

  const EditListingWindows({
    super.key,
    required this.name,
    required this.price,
    required this.available,
    required this.duration,
    required this.condition,
    required this.description,
    required this.category,
  });

  @override
  State<EditListingWindows> createState() => _EditListingWindowsState();
}

class _EditListingWindowsState extends State<EditListingWindows> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController durationController;
  late TextEditingController conditionController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;

  bool availability = false;
  DateTime focusedDay = DateTime.now();

  // Example booked dates
  final List<DateTime> bookedSlots = [
    DateTime.utc(2025, 11, 5),
    DateTime.utc(2025, 11, 6),
    DateTime.utc(2025, 11, 7),
    DateTime.utc(2025, 11, 8),
    DateTime.utc(2025, 11, 9),
    DateTime.utc(2025, 11, 20),
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price);
    durationController = TextEditingController(text: widget.duration);
    conditionController = TextEditingController(text: widget.condition);
    descriptionController = TextEditingController(text: widget.description);
    categoryController = TextEditingController(text: widget.category);

    availability = widget.available;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Listing"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(14),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  "https://www.cnet.com/a/img/resize/fb5194cdd6cd0cefbf020204f7d35cd48b8ed787/hub/2020/01/28/5284e5a2-1519-4d09-a07e-d50b317c954e/01-acer-nitro-5-an517-51-56yw.jpg?auto=webp&width=768",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Listing title
            _label("Listing Title"),
            _textField(nameController),

            const SizedBox(height: 20),

            // Price
            _label("Price (RM)"),
            _textField(priceController, inputType: TextInputType.number),

            const SizedBox(height: 20),

            // Availability
            _label("Availability"),
            SwitchListTile(
              title: Text(availability ? "Available" : "Unavailable"),
              value: availability,
              onChanged: (val) {
                setState(() => availability = val);
              },
            ),

            const SizedBox(height: 20),

            // Duration
            _label("Rental Duration"),
            _textField(durationController),

            const SizedBox(height: 20),

            // Condition
            _label("Condition"),
            _textField(conditionController),

            const SizedBox(height: 20),

            // Category
            _label("Category"),
            _textField(categoryController),

            const SizedBox(height: 20),

            // Description
            _label("Description"),
            _textField(descriptionController, maxLines: 4),

            const SizedBox(height: 30),

            const Text(
              "Booked Slots",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            TableCalendar(
              locale: "en_US",
              rowHeight: 40,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              availableGestures: AvailableGestures.none,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
                  if (bookedSlots.any((d) => isSameDay(d, day))) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${day.day}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  "name": nameController.text,
                  "price": priceController.text,
                  "available": availability,
                  "duration": durationController.text,
                  "condition": conditionController.text,
                  "description": descriptionController.text,
                  "category": categoryController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  // COMPONENTS
  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _textField(TextEditingController controller,
      {int maxLines = 1, TextInputType inputType = TextInputType.text}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
*/