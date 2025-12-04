import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pinjamtech_app/models/device_model.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);
  
  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _depositController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _specificationController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _rentDurationController = TextEditingController();
  
  String? selectedCategory;
  String? selectedCondition;
  String? selectedMaxDays = '30';
  bool isAvailable = true;
  String? imagePath;
  
  Position? _currentPosition;
  String _locationMessage = 'Location not set';
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    selectedCondition = 'Good';
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _priceController.dispose();
    _depositController.dispose();
    _descriptionController.dispose();
    _specificationController.dispose();
    _locationController.dispose();
    _brandController.dispose();
    _rentDurationController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = 'Location services are disabled';
          _isLoadingLocation = false;
        });
        _showLocationServiceDialog();
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = 'Location permission denied';
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage = 'Location permission permanently denied';
          _isLoadingLocation = false;
        });
        _showPermissionDialog();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _locationMessage = 'Lat: ${position.latitude.toStringAsFixed(6)}, Long: ${position.longitude.toStringAsFixed(6)}';
        _locationController.text = _locationMessage;
        _isLoadingLocation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location captured successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _locationMessage = 'Error getting location: $e';
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text('Please enable location services to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openLocationSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
            'Location permission is permanently denied. Please enable it in app settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _publishListing() {
    // Validate required fields
    if (_itemNameController.text.isEmpty || 
        _priceController.text.isEmpty || 
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Create Device object
    final newDevice = Device(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _itemNameController.text,
      brand: _brandController.text.isNotEmpty ? _brandController.text : 'Generic',
      pricePerDay: double.tryParse(_priceController.text) ?? 0.0,
      imageUrl: imagePath ?? 'https://via.placeholder.com/400x300?text=${_itemNameController.text}',
      isAvailable: isAvailable,
      maxRentalDays: int.tryParse(selectedMaxDays ?? '30') ?? 30,
      condition: selectedCondition ?? 'Good',
      description: _descriptionController.text,
      category: selectedCategory ?? 'General',
      bookedSlots: [],
    );

    // TODO: Save to backend
    if (_currentPosition != null) {
      print('Publishing with location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}');
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Listing published successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context, newDevice); // Return the created device
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Listing'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: _publishListing,
            child: const Text(
              'Publish',
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
            // Add Photo Section
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    imagePath = 'https://via.placeholder.com/400x300';
                  });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: imagePath != null 
                      ? NetworkImage(imagePath!) 
                      : null,
                  child: imagePath == null
                      ? const Icon(
                          Icons.camera_alt, 
                          size: 40, 
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Item Name
            TextField(
              controller: _itemNameController,
              decoration: const InputDecoration(
                labelText: 'Item Name *',
                border: OutlineInputBorder(),
                hintText: 'e.g., MacBook Pro M2',
              ),
            ),
            const SizedBox(height: 20),
            
            // Brand
            TextField(
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Brand (Optional)',
                border: OutlineInputBorder(),
                hintText: 'e.g., Apple, Samsung, Dell',
              ),
            ),
            const SizedBox(height: 20),
            
            // Rental Price
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Rental Price per Day *',
                border: OutlineInputBorder(),
                prefixText: 'RM ',
                hintText: 'Enter daily rental price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Deposit
            TextField(
              controller: _depositController,
              decoration: const InputDecoration(
                labelText: 'Deposit (Optional)',
                border: OutlineInputBorder(),
                prefixText: 'RM ',
                hintText: 'Enter security deposit amount',
              ),
              keyboardType: TextInputType.number,
            ),
            
            // Category Section
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category *',
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: <String>['Laptops', 'Tablets', 'Phones', 'XR/VR Box', 'Other']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
            
            // Condition Section
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Condition',
                border: OutlineInputBorder(),
              ),
              value: selectedCondition,
              items: <String>['Like New', 'Excellent', 'Good', 'Fair', 'Poor']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCondition = newValue;
                });
              },
            ),
            
            // Max Rental Days
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Maximum Rental Period',
                border: OutlineInputBorder(),
                hintText: 'Select maximum rental days',
              ),
              value: selectedMaxDays,
              items: <String>['7', '15', '30', '60', '90']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text('$value days'),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMaxDays = newValue;
                });
              },
            ),
            
            // Availability Toggle
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Make item available for rent'),
              subtitle: const Text('Turn off if item is being repaired'),
              value: isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                });
              },
              activeColor: Colors.green,
            ),

            // Rent Duration
            const SizedBox(height: 10),
            TextField(
              controller: _rentDurationController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Rent Duration Details',
                border: OutlineInputBorder(),
                hintText: 'Describe any restrictions or special rental terms',
              ),
            ),

            const SizedBox(height: 20),
            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                hintText: 'Describe your item in detail',
              ),
            ),
            
            const SizedBox(height: 20),
            // Specification
            TextField(
              controller: _specificationController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Specification',
                border: OutlineInputBorder(),
                hintText: 'Enter device specifications (RAM, Storage, etc.)',
              ),
            ),
            
            const SizedBox(height: 20),
            // Location Section
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: _currentPosition != null
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _locationMessage,
                          style: TextStyle(
                            color: _currentPosition != null
                                ? Colors.black87
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoadingLocation ? null : _getCurrentLocation,
                      icon: _isLoadingLocation
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.my_location),
                      label: Text(_isLoadingLocation
                          ? 'Getting Location...'
                          : 'Get Current Location'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Or enter manually',
                      border: OutlineInputBorder(),
                      hintText: 'Where is the item located?',
                      prefixIcon: Icon(Icons.edit_location),
                    ),
                  ),
                ],
              ),
            ),
            
            // Submit Button at the bottom
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _publishListing,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Submit Listing',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Text(
                'or use the "Publish" button in the top bar',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            // Required fields note
            const SizedBox(height: 20),
            Text(
              '* Required fields: Item Name, Price, Category',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}