import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:orbix_chat/features/home/presentation/widgets/chat_input_bar.dart';

class ChatInputBarContainer extends StatelessWidget {
  final void Function(String text) onSend;
  const ChatInputBarContainer({required this.onSend, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ChatInputBar(
                onSend: (text, _) => onSend(text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
