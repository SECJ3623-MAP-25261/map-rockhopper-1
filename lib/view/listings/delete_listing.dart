// delete_listing.dart (updated)
import 'package:flutter/material.dart';
import 'package:pinjamtech_app/models/device_model.dart';

class DeleteListing extends StatelessWidget {
  final Device device;
  
  const DeleteListing({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Listing'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                'Are you sure to delete "${device.name}"?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'This action cannot be undone.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(device.imageUrl),
                        ),
                        title: Text(device.name),
                        subtitle: Text('RM ${device.pricePerDay.toStringAsFixed(2)}/day'),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Booked dates:'),
                            Text('${device.bookedSlots.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // No Button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          minimumSize: const Size(120, 50),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                  
                  // Yes Button
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          _deleteListing(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(120, 50),
                        ),
                        child: const Text('Delete'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteListing(BuildContext context) {
    // TODO: Implement actual delete logic here
    // This would typically involve:
    // 1. Calling an API to delete the listing from backend
    // 2. Removing from local state/cache
    // 3. Navigating to rental listing screen
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${device.name}" has been deleted'),
        backgroundColor: Colors.green,
      ),
    );
    
    // Navigate to rental listing screen
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}