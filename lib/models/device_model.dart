// device_model.dart

class Device {
  final String id;
  final String name;
  final String brand;
  final double pricePerDay;
  final String imageUrl;
  final bool isAvailable;
  final int maxRentalDays;
  final String condition;

  // Add missing fields:
  final String description;
  final String category;
  final List<DateTime> bookedSlots;

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.imageUrl,
    required this.isAvailable,
    required this.maxRentalDays,
    required this.condition,
    this.description = 'No description provided',
    this.category = 'General',
    this.bookedSlots = const [],
  });
}