import 'package:flutter/material.dart';
import 'rentee_chat_screen.dart';

class RenterChatListScreen extends StatefulWidget {
  const RenterChatListScreen({super.key});

  @override
  State<RenterChatListScreen> createState() => _RenterChatListScreenState();
}

class _RenterChatListScreenState extends State<RenterChatListScreen> {
  List<Map<String, dynamic>> chats = [
    {
      "item": "MacBook Air M4 2024",
      "username": "Anonym123",
      "time": "13:13",
      "inquiry": "Is this still available?",
      "itemPrice": "RM 17/day",
      "unread": 2,
    },
    {
      "item": "ASUS ROG Zephyrus G14",
      "username": "JohnDoe",
      "time": "11:34",
      "inquiry": "Can we negotiate the price?",
      "itemPrice": "RM 25/day",
      "unread": 0,
    },
    {
      "item": "Canon M50 Camera",
      "username": "JaneSmith",
      "time": "10:43",
      "inquiry": "Where can we meet?",
      "itemPrice": "RM 15/day",
      "unread": 1,
    },
    {
      "item": "iPhone 15 Pro",
      "username": "MikeChen",
      "time": "08:17",
      "inquiry": "Any scratches?",
      "itemPrice": "RM 12/day",
      "unread": 0,
    },
  ];

  void _markAsRead(int index) {
    setState(() {
      chats[index]["unread"] = 0; // Clear unread count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inquiries"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (_, i) {
          final chat = chats[i];
          
          final String item = chat["item"] as String;
          final String username = chat["username"] as String;
          final String time = chat["time"] as String;
          final String inquiry = chat["inquiry"] as String;
          final String itemPrice = chat["itemPrice"] as String;
          final int unread = chat["unread"] as int;
          
          return InkWell(
            onTap: () {
              _markAsRead(i); // Clear unread count before navigation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RenterChatScreen(
                    chatName: username,
                    itemName: item,
                    itemPrice: itemPrice,
                    initialInquiry: inquiry,
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: _getAvatarColor(username),
                    child: Text(
                      username.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (unread > 0)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    unread.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          username,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          inquiry,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  // Price & Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          itemPrice,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getAvatarColor(String username) {
    final colors = [
      Colors.green.shade700,
      Colors.blue.shade700,
      Colors.orange.shade700,
      Colors.purple.shade700,
    ];
    
    String cleanUsername = username.split(' ').first;
    return colors[cleanUsername.hashCode % colors.length];
  }
}