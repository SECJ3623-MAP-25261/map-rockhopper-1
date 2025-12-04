/*import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../listings/edit_listing_windows.dart';

class EditListing extends StatefulWidget {
final String name;
final String price;
final bool available;
final String duration;
final String condition;
final String description;
final String category;

const EditListing({
    Key? key,
    required this.name,
    required this.price,
    required this.available,
    required this.duration,
    required this.condition,
    required this.description,
    required this.category,
}) : super(key: key);

@override
State<EditListing> createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
DateTime focusedDay = DateTime.now();

// Simulated booked slots
final List<DateTime> bookedSlots = [
    DateTime.utc(2025, 11, 5),
    DateTime.utc(2025, 11, 6),
    DateTime.utc(2025, 11, 7),
    DateTime.utc(2025, 11, 8),
    DateTime.utc(2025, 11, 9),
    DateTime.utc(2025, 11, 20),
];

void _confirmDelete() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Delete Listing"),
        content: const Text(
          "Are you sure you want to delete this listing?\nThis action cannot be undone.",
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context); // close popup
              _deleteListing();
            },
          ),
        ],
      );
    },
  );
}

void _deleteListing() {
  // TODO: integrate actual delete logic
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Listing deleted")),
  );

  Navigator.pop(context); // go back after delete
}

@override
Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text('Acer Nitro V15'),
        actions: [
        PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
                onSelected: (value) {
            if (value == 'edit_window') {
                Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditListingWindows(
                    name: widget.name,
                    price: widget.price,
                    available: widget.available,
                    duration: widget.duration,
                    condition: widget.condition,
                    description: widget.description,
                    category: widget.category,
                    ),
                ),
                );
            }
             if (value == 'delete') {
    _confirmDelete();
  }
},
            

            itemBuilder: (BuildContext context) {
            return const [
                PopupMenuItem<String>(
                value: 'edit_window',
                child: Text('Edit Listing'),
                ),
                PopupMenuItem<String>(
                value: 'delete',
                child: Text(
                    'Delete Listing',
                    style: TextStyle(color: Colors.red),
                    ),
                ),
            ];
            },
        ),
        ],
    ),

    body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // IMAGE PLACEHOLDER
            Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                'https://cdn.uc.assets.prezly.com/26bcc88a-0478-40a1-8f29-cf52ef86196c/nitro_v15_special_angle_2.png',
                fit: BoxFit.cover,
                ),
            ),
            ),

            const SizedBox(height: 16),

            // PRODUCT INFO
            Text(
            widget.name,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
            ),
            ),

            const SizedBox(height: 8),

            Text(
            widget.price,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
            ),
            ),

            const SizedBox(height: 4),

            Row(
            children: [
                Icon(
                Icons.circle,
                size: 12,
                color: widget.available ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(widget.available ? "Available" : "Not Available"),
            ],
            ),

            const SizedBox(height: 4),
            Text("Duration: ${widget.duration}"),

            const SizedBox(height: 4),
            Text("Condition: ${widget.condition}"),

            const SizedBox(height: 4),
            Text("Category: ${widget.category}"),

            const SizedBox(height: 12),

            const Text(
            "Description:",
            style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            Text(widget.description),

            const SizedBox(height: 20),

            // CALENDAR (READ-ONLY)
            const Text(
            "Booked Slots:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TableCalendar(
            locale: "en_US",
            rowHeight: 40,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
            ),
            firstDay: DateTime.utc(2025, 10, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            availableGestures: AvailableGestures.none, // read-only

            calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                if (bookedSlots.any((d) => isSameDay(d, day))) {
                    return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                        child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                        ),
                    ),
                    );
                }
                return null;
                },
            ),
            ),
        ],
        ),
    ),
    );
}
}
*/