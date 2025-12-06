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
  final String description;
  final String category;
  final List<DateTime> bookedSlots;
  final double? deposit; // Add if needed
  final String? specifications; // Add if needed
  final String? location; // Add if needed

  Device({
    required this.id,
    required this.name,
    required this.brand,
    required this.pricePerDay,
    required this.imageUrl,
    required this.isAvailable,
    required this.maxRentalDays,
    required this.condition,
    required this.description,
    required this.category,
    required this.bookedSlots,
    this.deposit,
    this.specifications,
    this.location,
  });

  // Add copyWith method for easier updates
  Device copyWith({
    String? id,
    String? name,
    String? brand,
    double? pricePerDay,
    String? imageUrl,
    bool? isAvailable,
    int? maxRentalDays,
    String? condition,
    String? description,
    String? category,
    List<DateTime>? bookedSlots,
    double? deposit,
    String? specifications,
    String? location,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      maxRentalDays: maxRentalDays ?? this.maxRentalDays,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      category: category ?? this.category,
      bookedSlots: bookedSlots ?? this.bookedSlots,
      deposit: deposit ?? this.deposit,
      specifications: specifications ?? this.specifications,
      location: location ?? this.location,
    );
  }
}