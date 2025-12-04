import 'package:flutter/material.dart';

class RenterQuickReplies extends StatelessWidget {
  final Function(String, int) onReplySelected;
  final String itemPrice;
  final Set<int> usedReplies;

  const RenterQuickReplies({
    super.key,
    required this.onReplySelected,
    required this.itemPrice,
    this.usedReplies = const {},
  });

  @override
  Widget build(BuildContext context) {
    final replies = [
      "Yes, it's available!",
      "The price is $itemPrice",
      "We can meet at KLCC or Mid Valley",
      "No defects, it's in perfect condition",
      "I require a security deposit of RM 100",
      "Available for pickup tomorrow",
      "Price is negotiable for longer rentals",
      "Comes with original accessories",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.green.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, 
                   color: Colors.green.shade700, size: 16),
              const SizedBox(width: 6),
              const Text(
                "Quick answers for renters",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Horizontal scrollable list - ALL replies always visible
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: replies.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    right: index < replies.length - 1 ? 8 : 0,
                  ),
                  child: ElevatedButton(
                    onPressed: () => onReplySelected(replies[index], index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green.shade800,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.green.shade200),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      replies[index],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}