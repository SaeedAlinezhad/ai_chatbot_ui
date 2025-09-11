import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbix_chat/features/home/domain/entities/chat_message.dart';
import '../bloc/home_bloc.dart';
import '../widgets/chat_input_bar_container.dart';
import '../widgets/chat_message_list.dart';
import '../widgets/main_content.dart';
import '../widgets/foreground_buttons.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/gradient_obj.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final messages = state is HomeLoaded ? state.messages : <ChatMessage>[];
          final isVoiceInput = (state is HomeInitial) ? state.isVoiceInputActive :(state is HomeLoaded) ? state.isVoiceInputActive: false;

          final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
          final showMainContent = !isKeyboardOpen && messages.isEmpty && !isVoiceInput;

          return Scaffold(
            extendBody: true,
            backgroundColor: Colors.transparent,
            drawer: const DrawerWidget(),
            body: Stack(
              children: [
                const GradientCircle(),
                if (messages.isNotEmpty) ChatMessageList(messages: messages),
                if (showMainContent) const MainContent(),
                const ForegroundButtons(),
                ChatInputBarContainer(
                  onSend: (text) {
                    context.read<HomeBloc>().add(SendMessageEvent(text));
                  },
                ),
              ],
            ),
          );
        },
    
    );
  }
}
