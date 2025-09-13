// core/widgets/chat_input_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:orbix_chat/features/home/presentation/bloc/home_bloc.dart';
import 'package:orbix_chat/features/voice_input/presentation/cubit/voice_cubit.dart';
import 'package:orbix_chat/features/voice_input/presentation/pages/voice_input_screen.dart';
import 'package:orbix_chat/injection_container.dart';

class ChatInputBar extends StatefulWidget {
  final void Function(String text, String? imageUrl) onSend;
  final FocusNode? focusNode; 
  const ChatInputBar({required this.onSend, this.focusNode, super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();

  void _send() {
    if (_controller.text.isNotEmpty) {
      widget.onSend(_controller.text, null);
      _controller.clear();

      widget.focusNode?.requestFocus();
    }
  }

  Future<String?> showVoiceInputDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) =>  Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 400,
          child: BlocProvider(
        create: (_) => sl<VoiceCubit>(),
        child: const VoiceInputScreen(),
      ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: const Color.fromARGB(57, 63, 57, 90),
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Iconsax.camera_copy, color: Colors.white),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(57, 63, 57, 90),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _controller,
              focusNode: widget.focusNode,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Type Message',
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Iconsax.send_1_copy, color: Colors.white),
                  onPressed: _send,
                ),
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Material(
          color: const Color.fromARGB(57, 63, 57, 90),
          shape: const CircleBorder(),
          child: IconButton(
            icon: const Icon(Iconsax.microphone_copy, color: Colors.white),
            onPressed: () async {
                  context.read<HomeBloc>().add(const ToggleVoiceInputEvent(true));
              final result = await showVoiceInputDialog(context);
              if (result != null && result.isNotEmpty) {
                setState(() {
                  _controller.text = result;
                  _controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: _controller.text.length),
                  );
                });
                widget.focusNode?.requestFocus(); 
              }
            },
          ),
        ),
      ],
    );
  }
}
