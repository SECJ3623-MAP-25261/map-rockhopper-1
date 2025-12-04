import 'package:flutter/material.dart';

class QuickReplies extends StatelessWidget {
  final Function(String, int) onReplySelected;
  final Set<int> usedReplies;

  const QuickReplies({
    super.key,
    required this.onReplySelected,
    this.usedReplies = const {},
  });

  @override
  Widget build(BuildContext context) {
    final replies = [
      "Hi! Is this still available?",
      "Is the price negotiable?",
      "Where can we meet?",
      "Can I pay in installments?",
      "Is the product has any defect?",
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, 
                   color: Colors.blue.shade700, size: 16),
              const SizedBox(width: 6),
              Text(
                "Quick questions to ask",
                style: TextStyle(
                  color: Colors.blue.shade800,
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
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey.shade300),
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