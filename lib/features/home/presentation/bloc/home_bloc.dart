import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orbix_chat/features/home/domain/entities/chat_message.dart';
import 'package:orbix_chat/features/home/domain/usecases/send_message_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SendMessageUseCase sendMessageUseCase;
  HomeBloc({required this.sendMessageUseCase})
      : super(const HomeInitial(isVoiceInputActive: false)) {
    on<SendMessageEvent>((event, emit) async {
      final previousMessages = state is HomeLoaded
          ? (state as HomeLoaded).messages
          : <ChatMessage>[];

      try {
        final newMessages = await sendMessageUseCase(event.text);

        final allMessages = List<ChatMessage>.from(previousMessages)
          ..addAll(newMessages);

        emit(HomeLoaded(allMessages));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<ClearMessagesEvent>((event, emit) async {
      emit(const HomeLoaded([]));
    });
    on<ToggleVoiceInputEvent>((event, emit) {
      if (state is HomeLoaded) {
        final currentState = state as HomeLoaded;
        emit(currentState.copyWith(
          isVoiceInputActive: event.voiceState,
        ));
      } else if (state is HomeInitial) {
        final currentState = state as HomeInitial;
        emit(currentState.copyWith(
          isVoiceInputActive: event.voiceState,
        ));
      }
    });
  }
}
