import 'package:flutter/material.dart';
import 'chat_bubble.dart';
import 'quick_reply.dart';
import 'message_input.dart';

class ChatScreen extends StatefulWidget {
  final String chatName;
  final String itemName;
  final String itemPrice;
  final bool isRenter;
  
  const ChatScreen({
    super.key,
    required this.chatName,
    required this.itemName,
    required this.itemPrice,
    required this.isRenter,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Map<String, dynamic>> messages;
  final TextEditingController _controller = TextEditingController();
  Set<int> usedQuickReplies = {}; // Track which quick replies have been used

  @override
  void initState() {
    super.initState();
    
    // Initialize empty chat (no previous messages)
    messages = [];
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        "fromMe": true, 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("chat"),
      ),
      body: Column(
        children: [
          // Item Details Section (From your image)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
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
                const SizedBox(height: 8),
                
                Row(
                  children: [
                    const Text(
                      "RM 17/day",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Rent Up to 30 days",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Make Offer Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey.shade300),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Make Offer",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                const Divider(height: 1),
                const SizedBox(height: 12),
                
                // User info
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
                          Text(
                            "@Renter",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
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
          
          // Quick Questions Section 
          QuickReplies(
            onReplySelected: sendQuickReply,
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