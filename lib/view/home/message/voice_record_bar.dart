import 'package:flutter/material.dart';

class VoiceRecordBar extends StatelessWidget {
  final int seconds;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  const VoiceRecordBar({
    super.key,
    required this.seconds,
    required this.onCancel,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Row(
        children: [
          // Cancel button
          IconButton(
            onPressed: onCancel,
            icon: Icon(Icons.close, color: Colors.red.shade700),
          ),
          
          // Recording visualization
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(20, (index) {
                    final active = index < (seconds % 20);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 3,
                      height: active ? 30 : 10,
                      decoration: BoxDecoration(
                        color: active ? Colors.red : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  "Recording... Slide to cancel",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          
          // Timer and send
          Column(
            children: [
              Text(
                "0:${seconds.toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade700,
                ),
                child: IconButton(
                  onPressed: onSend,
                  icon: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}