import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final String searchQuery;

  const ProductListScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Device> _devices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() {
    // Simulate API call delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _devices = _getSampleDevices();
        _isLoading = false;
      });
    });
  }

  List<Device> _getSampleDevices() {
    return [
      Device(
        id: '1',
        name: 'Lenovo Ideapad 3',
        brand: 'Lenovo',
        pricePerDay: 8.0,
        imageUrl: 'https://via.placeholder.com/150x100/4A90E2/FFFFFF?text=Lenovo',
        isAvailable: true,
        maxRentalDays: 60,
        condition: 'Rarely used',
      ),
      Device(
        id: '2',
        name: 'Acer Nitro V15',
        brand: 'Acer',
        pricePerDay: 10.0,
        imageUrl: 'https://via.placeholder.com/150x100/50E3C2/FFFFFF?text=Acer+Nitro',
        isAvailable: false,
        maxRentalDays: 60,
        condition: 'Like new',
      ),
      Device(
        id: '3',
        name: 'MacBook Air M1',
        brand: 'Apple',
        pricePerDay: 15.0,
        imageUrl: 'https://via.placeholder.com/150x100/9013FE/FFFFFF?text=MacBook',
        isAvailable: true,
        maxRentalDays: 30,
        condition: 'New',
      ),
      Device(
        id: '4',
        name: 'ASUS ROG Strix',
        brand: 'ASUS',
        pricePerDay: 12.0,
        imageUrl: 'https://via.placeholder.com/150x100/417505/FFFFFF?text=ASUS+ROG',
        isAvailable: true,
        maxRentalDays: 90,
        condition: 'Heavily used',
      ),
      Device(
        id: '5',
        name: 'Dell XPS 13',
        brand: 'Dell',
        pricePerDay: 11.0,
        imageUrl: 'https://via.placeholder.com/150x100/F5A623/FFFFFF?text=Dell+XPS',
        isAvailable: true,
        maxRentalDays: 45,
        condition: 'Rarely used',
      ),
    ];
  }

  void _showFilters() {
    // Will implement filter functionality later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filter functionality coming soon')),
    );
  }

  void _showSortOptions() {
    // Will implement sort functionality later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sort functionality coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.searchQuery,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Header with Sort and Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              children: [
                const Text(
                  '${6} results', // Placeholder count
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // Sort Button
                TextButton.icon(
                  onPressed: _showSortOptions,
                  icon: const Icon(Icons.sort, size: 18),
                  label: const Text('Sort by'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                // Filter Button
                TextButton.icon(
                  onPressed: _showFilters,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text('Filter'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          
          // Product List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _devices.isEmpty
                    ? const Center(
                        child: Text(
                          'No devices found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _devices.length,
                        itemBuilder: (context, index) {
                          final device = _devices[index];
                          return DeviceCard(device: device);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

// Device Model
class Device {
  final String id;
  final String name;
  final String brand;
  final double pricePerDay;
  final String imageUrl;
  final bool isAvailable;
  final int maxRentalDays;
  final String condition;

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.imageUrl,
    required this.isAvailable,
    required this.maxRentalDays,
    required this.condition,
  });
}

// Device Card Widget
class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device Image
          Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: NetworkImage(device.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Device Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  device.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'RM ${device.pricePerDay.toStringAsFixed(0)}/day',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: device.isAvailable ? Colors.green[50] : Colors.red[50],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: device.isAvailable ? Colors.green : Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: device.isAvailable ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            device.isAvailable ? 'Available' : 'Not Available',
                            style: TextStyle(
                              fontSize: 12,
                              color: device.isAvailable ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'Up to ${device.maxRentalDays} days',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Condition: ${device.condition}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}