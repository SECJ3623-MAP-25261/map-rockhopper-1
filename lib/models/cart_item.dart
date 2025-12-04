//cart_item.dart

// models/cart_item.dart (updated)
class CartItem {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String condition;
  final String category;
  final String brand;
  final int maxRentalDays;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.condition,
    required this.category,
    required this.brand,
    required this.maxRentalDays,
    this.isSelected = true,
  });

  int get rentalDays => endDate.difference(startDate).inDays + 1;

  double get totalPrice => price * rentalDays;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'rentalDays': rentalDays,
      'condition': condition,
      'category': category,
      'brand': brand,
      'maxRentalDays': maxRentalDays,
      'isSelected': isSelected,
      'totalPrice': totalPrice,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      condition: map['condition'],
      category: map['category'],
      brand: map['brand'],
      maxRentalDays: map['maxRentalDays'],
      isSelected: map['isSelected'] ?? true,
    );
  }
}