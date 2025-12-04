import 'package:flutter/material.dart';
import 'attachment_menu.dart';
import 'voice_record_bar.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSendMessage;
  final VoidCallback onSendVoiceMessage;
  final Function(String) onSendAttachment;
  
  const MessageInput({
    super.key,
    required this.controller,
    required this.onSendMessage,
    required this.onSendVoiceMessage,
    required this.onSendAttachment,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool recording = false;
  int recordSeconds = 0;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      hasText = widget.controller.text.trim().isNotEmpty;
    });
  }

  void openAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => AttachmentMenu(
        onAttachmentSelected: (type) {
          widget.onSendAttachment(type);
          Navigator.pop(context);
        },
      ),
    );
  }

  void startRecording() {
    setState(() {
      recording = true;
      recordSeconds = 0;
    });
    
    _startRecordingTimer();
  }

  void _startRecordingTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && recording) {
        setState(() {
          recordSeconds++;
        });
        _startRecordingTimer();
      }
    });
  }

  void stopRecording() {
    setState(() => recording = false);
  }

  void sendVoiceMessage() {
    stopRecording();
    widget.onSendVoiceMessage();
  }

  void sendTextMessage() {
    final text = widget.controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recording) {
      return VoiceRecordBar(
        seconds: recordSeconds,
        onCancel: stopRecording,
        onSend: sendVoiceMessage,
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            onPressed: openAttachmentMenu,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey.shade600,
              size: 24,
            ),
          ),
          
          // TextField
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: widget.controller,
                decoration: const InputDecoration(
                  hintText: "Type here...",
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => sendTextMessage(),
              ),
            ),
          ),
          
          // Mic or Send button
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasText ? Colors.blue : Colors.grey.shade300,
            ),
            child: IconButton(
              onPressed: hasText ? sendTextMessage : startRecording,
              icon: Icon(
                hasText ? Icons.send : Icons.mic,
                color: hasText ? Colors.white : Colors.black,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}