// add_item_cart.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pinjamtech_app/models/device_model.dart';
import 'package:pinjamtech_app/models/cart_item.dart';

class AddItemToCart extends StatefulWidget {
  final Device device;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  const AddItemToCart({
    Key? key,
    required this.device,
    this.initialStartDate,
    this.initialEndDate,
  }) : super(key: key);

  @override
  State<AddItemToCart> createState() => _AddItemToCartState();
}

class _AddItemToCartState extends State<AddItemToCart> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  CalendarFormat calendarFormat = CalendarFormat.month;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  void initState() {
    super.initState();
    // Initialize with provided dates or default to next available
    selectedStartDate = widget.initialStartDate;
    selectedEndDate = widget.initialEndDate;
    if (selectedStartDate != null) {
      focusedDay = selectedStartDate!;
    }
  }

  // Helper method to check if a date is bookable
  bool _isDateBookable(DateTime date) {
    // Check if date is in the past
    if (date.isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      return false;
    }
    
    // Check if date is within max rental days from today
    final maxDate = DateTime.now().add(Duration(days: widget.device.maxRentalDays));
    if (date.isAfter(maxDate)) {
      return false;
    }
    
    // Check if date is already booked
    if (widget.device.bookedSlots.any((d) => isSameDay(d, date))) {
      return false;
    }
    
    return true;
  }

  // Helper method to get the next available date
  DateTime _getNextAvailableDate(DateTime fromDate) {
    DateTime current = fromDate;
    while (!_isDateBookable(current)) {
      current = current.add(const Duration(days: 1));
    }
    return current;
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = selectedStartDate != null && selectedEndDate != null
        ? selectedEndDate!.difference(selectedStartDate!).inDays + 1
        : 0;
    final totalPrice = totalDays * widget.device.pricePerDay;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Rental Dates'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Information Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.device.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.device.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.device.brand,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'RM ${widget.device.pricePerDay.toStringAsFixed(2)}/day',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
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
                              const SizedBox(width: 4),
                              Text(
                                widget.device.isAvailable ? 'Available' : 'Not Available',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.timer,
                                size: 12,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Max ${widget.device.maxRentalDays} days',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Date Range Selection Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Rental Dates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      selectedStartDate == null
                          ? 'Select start and end dates'
                          : selectedEndDate == null
                              ? 'Select end date'
                              : '${selectedStartDate!.day}/${selectedStartDate!.month}/${selectedStartDate!.year} - '
                                '${selectedEndDate!.day}/${selectedEndDate!.month}/${selectedEndDate!.year}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                if (selectedStartDate != null && selectedEndDate != null)
                  Chip(
                    label: Text('$totalDays day${totalDays > 1 ? 's' : ''}'),
                    backgroundColor: Colors.blue[50],
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Availability Info
            if (!widget.device.isAvailable)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This device is currently not available for rental.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // Calendar
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: widget.device.maxRentalDays)),
                  focusedDay: focusedDay,
                  calendarFormat: calendarFormat,
                  rangeStartDay: selectedStartDate,
                  rangeEndDay: selectedEndDate,
                  rangeSelectionMode: rangeSelectionMode,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'Week',
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    rangeStartDecoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    withinRangeDecoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    disabledDecoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                  ),
                  selectedDayPredicate: (day) => false,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!widget.device.isAvailable) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This device is not available for rental'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!_isDateBookable(selectedDay)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('This date is not available for booking'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    setState(() {
                      if (selectedStartDate == null) {
                        selectedStartDate = selectedDay;
                      } else if (selectedEndDate == null &&
                          selectedDay.isAfter(selectedStartDate!)) {
                        selectedEndDate = selectedDay;
                        
                        // Validate the entire range
                        DateTime current = selectedStartDate!;
                        while (current.isBefore(selectedEndDate!) ||
                            isSameDay(current, selectedEndDate!)) {
                          if (!_isDateBookable(current)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${current.day}/${current.month}/${current.year} is not available'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            selectedStartDate = null;
                            selectedEndDate = null;
                            break;
                          }
                          current = current.add(const Duration(days: 1));
                        }
                      } else if (selectedDay.isBefore(selectedStartDate!)) {
                        selectedStartDate = selectedDay;
                        selectedEndDate = null;
                      } else {
                        selectedStartDate = null;
                        selectedEndDate = null;
                      }

                      this.focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      this.focusedDay = focusedDay;
                    });
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final isBooked = widget.device.bookedSlots.any((d) => isSameDay(d, day));
                      final isPast = day.isBefore(DateTime.now().subtract(const Duration(days: 1)));
                      final isBeyondMax = day.isAfter(DateTime.now().add(Duration(days: widget.device.maxRentalDays)));
                      
                      if (isPast || isBeyondMax || !widget.device.isAvailable || isBooked) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }
                      
                      return null;
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Price Summary
            if (selectedStartDate != null && selectedEndDate != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryRow('Price per day', 'RM ${widget.device.pricePerDay.toStringAsFixed(2)}'),
                      _buildSummaryRow('Rental duration', '$totalDays day${totalDays > 1 ? 's' : ''}'),
                      const Divider(),
                      _buildSummaryRow(
                        'Total Price',
                        'RM ${totalPrice.toStringAsFixed(2)}',
                        isBold: true,
                        color: Colors.green,
                      ),
                      if (totalDays > widget.device.maxRentalDays)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Note: Maximum rental period is ${widget.device.maxRentalDays} days',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        // Suggest next available date range
                        final nextDate = _getNextAvailableDate(DateTime.now());
                        selectedStartDate = nextDate;
                        selectedEndDate = nextDate;
                        focusedDay = nextDate;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Suggest Dates'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedStartDate != null && selectedEndDate != null && widget.device.isAvailable
                        ? () {
                            final cartItem = CartItem(
                              id: widget.device.id,
                              name: widget.device.name,
                              price: widget.device.pricePerDay,
                              image: widget.device.imageUrl,
                              description: widget.device.description,
                              condition: widget.device.condition,
                              category: widget.device.category,
                              startDate: selectedStartDate!,
                              endDate: selectedEndDate!,
                              brand: widget.device.brand,
                              maxRentalDays: widget.device.maxRentalDays,
                            );

                            // Add to cart using CartManager (you'll need to implement this)
                            // CartManager().addToCart(cartItem);
                            
                            // Pass the cart item back
                            Navigator.pop(context, cartItem);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Information about selection
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info, size: 20, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        'Booking Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Gray dates are unavailable (booked, past, or beyond ${widget.device.maxRentalDays}-day limit)',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '• Select start date, then end date',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '• Maximum rental period: ${widget.device.maxRentalDays} days',
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}