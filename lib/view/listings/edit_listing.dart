// edit_listing.dart (updated for Device model)
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'edit_listing_windows.dart';
import 'package:pinjamtech_app/models/device_model.dart';

class EditListing extends StatefulWidget {
  final Device device;
  final List<DateTime> bookedSlots;

  const EditListing({
    Key? key,
    required this.device,
    this.bookedSlots = const [],
  }) : super(key: key);

  @override
  State<EditListing> createState() => _EditListingState();
}

class _EditListingState extends State<EditListing> {
  DateTime focusedDay = DateTime.now();

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
        title: Text(widget.device.name),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'edit_window') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditListingWindows(
                      device: widget.device,
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
            // IMAGE
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.device.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.device_unknown, size: 60),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PRODUCT INFO
            Text(
              widget.device.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'RM ${widget.device.pricePerDay.toStringAsFixed(2)}/day',
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
                  color: widget.device.isAvailable ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 6),
                Text(widget.device.isAvailable ? "Available" : "Not Available"),
              ],
            ),

            const SizedBox(height: 4),
            Text("Brand: ${widget.device.brand}"),

            const SizedBox(height: 4),
            Text("Condition: ${widget.device.condition}"),

            const SizedBox(height: 4),
            Text("Category: ${widget.device.category}"),

            const SizedBox(height: 12),

            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),
            Text(widget.device.description),

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
              firstDay: DateTime.now().subtract(const Duration(days: 30)),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: focusedDay,
              availableGestures: AvailableGestures.none, // read-only

              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (widget.bookedSlots.any((d) => isSameDay(d, day))) {
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