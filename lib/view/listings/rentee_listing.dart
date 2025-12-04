/*import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../cart/cart_manager.dart';

class RenteeListing extends StatefulWidget {
  final String name;
  final String price;
  final List<DateTime> bookedSlots;

  const RenteeListing({
    super.key,
    required this.name,
    required this.price,
    required this.bookedSlots,
  });

  @override
  State<RenteeListing> createState() => _RenteeListingState();
}

class _RenteeListingState extends State<RenteeListing> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rent Device")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TITLE
            Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // PRICE
            Text(widget.price, style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            // CALENDAR
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (day, focused) {
                setState(() {
                  selectedDay = day;
                  focusedDay = focused;
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, _) {
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

            const SizedBox(height: 30),

            // BUTTON
            ElevatedButton(
              onPressed: () {
                if (selectedDay == null) {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      title: Text("No date selected"),
                      content: Text("Please select a date to rent."),
                    ),
                  );
                  return;
                }

                // Check if booked
                if (widget.bookedSlots.any(
                    (d) => isSameDay(d, selectedDay!))) {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      title: Text("Date unavailable"),
                      content: Text(
                        "This device is already booked on that day.",
                      ),
                    ),
                  );
                  return;
                }

                // VALID → add to cart
                CartManager().addToCart(
                  CartItem(
                    name: widget.name,
                    price: widget.price,
                    selectedDay: selectedDay!,
                  ),
                );

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Added to Cart"),
                    content: const Text("The item has been added to your cart."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Add to Renting Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
*/