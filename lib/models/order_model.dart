import 'package:flutter/material.dart';

enum OrderStatus {
  pending,
  confirmed,
  renting,
  returned,
}

class Order {
  final String id;
  final String deviceName;
  final String deviceImage;
  final double price;
  final int duration; // days rented

  final DateTime startDate;
  final DateTime endDate;
  final DateTime orderDate;

  final OrderStatus status;

  Order({
    required this.id,
    required this.deviceName,
    required this.deviceImage,
    required this.price,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.orderDate,
    required this.status,
  });

  // Total price
  double get totalPrice => price * duration;

  // Status text for UI
  String get statusText {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.confirmed:
        return "Confirmed";
      case OrderStatus.renting:
        return "Currently Renting";
      case OrderStatus.returned:
        return "Returned";
    }
  }

  // Status color mapping for UI
  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.renting:
        return Colors.green;
      case OrderStatus.returned:
        return Colors.purple;
    }
  }
}
