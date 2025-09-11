import 'package:flutter/material.dart';
import 'package:orbix_chat/features/home/domain/entities/chat_message.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  const ChatMessageList({required this.messages, super.key});

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) return const SizedBox.shrink();
    final maxWidth = MediaQuery.of(context).size.width * 0.7; // max 70% of screen

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(top: 100, bottom: 120),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[messages.length - 1 - index];
          return Align(
            alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: message.isUser ? Colors.deepPurple : Colors.grey.shade800,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: Radius.circular(message.isUser ? 20 : 0),
                    bottomRight: Radius.circular(message.isUser ? 0 : 20),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
