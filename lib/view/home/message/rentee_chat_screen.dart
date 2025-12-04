import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'rentee_quick_replies.dart';
import 'message_input.dart';

class RenterChatScreen extends StatefulWidget {
  final String chatName;
  final String itemName;
  final String itemPrice;
  final String initialInquiry;
  
  const RenterChatScreen({
    super.key,
    required this.chatName,
    required this.itemName,
    required this.itemPrice,
    required this.initialInquiry,
  });

  @override
  State<RenterChatScreen> createState() => _RenterChatScreenState();
}

class _RenterChatScreenState extends State<RenterChatScreen> {
  late List<Map<String, dynamic>> messages;
  final TextEditingController _controller = TextEditingController();
  Set<int> usedQuickReplies = {}; // Track which quick replies have been used

  @override
  void initState() {
    super.initState();
    
    // Initialize with the initial inquiry from the borrower
    messages = [
      {
        "fromMe": false, // Borrower sent this
        "text": widget.initialInquiry,
        "time": "10:30 AM",
        "senderName": widget.chatName,
      },
    ];
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        "fromMe": true, // Lender (Renter) sending
        "text": text,
        "time": _formatTime(DateTime.now()),
        "senderName": "You",
      });
    });

    _controller.clear();
  }

  void sendQuickReply(String text, int index) {
    sendMessage(text);
    setState(() {
      usedQuickReplies.add(index); // Mark this quick reply as used
    });
  }

  void sendVoiceMessage() {
    setState(() {
      messages.add({
        "fromMe": true,
        "text": "🎤 Voice message",
        "time": _formatTime(DateTime.now()),
        "senderName": "You",
      });
    });
  }

  void sendAttachment(String type) {
    setState(() {
      messages.add({
        "fromMe": true,
        "text": "📎 [$type attachment]",
        "time": _formatTime(DateTime.now()),
        "senderName": "You",
      });
    });
  }

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour < 12 ? 'AM' : 'PM';
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  void markAsRented() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Mark as Rented"),
        content: const Text("Are you sure you want to mark this item as rented?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item marked as rented")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("chat"),
        actions: [
          IconButton(
            onPressed: markAsRented,
            icon: Icon(Icons.check_circle_outline, color: Colors.green.shade700),
            tooltip: "Mark as Rented",
          ),
        ],
      ),
      body: Column(
        children: [
          // Item Details Section (Lender's item being inquired about)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Available",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Text(
                        widget.itemPrice,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                
                // User info (Borrower who is inquiring)
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade700,
                      child: Text(
                        widget.chatName.substring(0, 1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.chatName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "@Renter",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Inquiry",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Messages List
          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Text(
                      "No messages yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return ChatBubble(
                        text: msg["text"] as String,
                        isSender: msg["fromMe"] as bool,
                        time: msg["time"] as String,
                        senderName: msg["senderName"] as String,
                      );
                    },
                  ),
          ),
          
          // Quick Replies Section 
          RenterQuickReplies(
            onReplySelected: sendQuickReply,
            itemPrice: widget.itemPrice,
            usedReplies: usedQuickReplies,
          ),
          
          // Message Input
          MessageInput(
            controller: _controller,
            onSendMessage: sendMessage,
            onSendVoiceMessage: sendVoiceMessage,
            onSendAttachment: sendAttachment,
          ),
        ],
      ),
    );
  }
}