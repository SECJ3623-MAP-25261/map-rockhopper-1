// edit_listing_windows.dart
import 'package:flutter/material.dart';
import 'package:pinjamtech_app/models/device_model.dart';

class EditListingWindows extends StatefulWidget {
  final Device device;
  
  const EditListingWindows({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<EditListingWindows> createState() => _EditListingWindowsState();
}

class _EditListingWindowsState extends State<EditListingWindows> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late bool _isAvailable;
  String? _selectedCategory;
  String? _selectedCondition;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.device.name);
    _priceController = TextEditingController(text: widget.device.pricePerDay.toString());
    _descriptionController = TextEditingController(text: widget.device.description);
    _isAvailable = widget.device.isAvailable;
    _selectedCategory = widget.device.category;
    _selectedCondition = widget.device.condition;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // TODO: Save changes to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Listing'),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.device.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.camera_alt, size: 40);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                        onPressed: () {
                          // TODO: Implement image picker
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Item Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Brand
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Brand',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.lock),
                hintText: widget.device.brand,
              ),
            ),
            const SizedBox(height: 20),

            // Rental Price
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Rental Price per Day',
                border: OutlineInputBorder(),
                prefixText: 'RM ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Availability Toggle
            SwitchListTile(
              title: const Text('Available for Rent'),
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value;
                });
              },
            ),

            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              value: _selectedCategory,
              items: <String>['Laptops', 'Tablets', 'Phones', 'XR/VR Box', 'Accessories', 'Other']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // Condition Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Condition',
                border: OutlineInputBorder(),
              ),
              value: _selectedCondition,
              items: <String>['Like New', 'Excellent', 'Good', 'Fair', 'Poor']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCondition = newValue;
                });
              },
            ),
            const SizedBox(height: 20),

            // Max Rental Days
            ListTile(
              title: const Text('Maximum Rental Days'),
              subtitle: Text('${widget.device.maxRentalDays} days'),
              trailing: const Icon(Icons.lock, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 20),

            // Booked Slots Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Booking Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Currently ${widget.device.bookedSlots.length} booked dates',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Booked dates cannot be modified. To cancel bookings, please contact renters.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}