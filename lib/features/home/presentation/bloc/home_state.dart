part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  final bool isVoiceInputActive;
  const HomeInitial({required this.isVoiceInputActive});

  HomeInitial copyWith({
    List<ChatMessage>? messages,
    bool? isVoiceInputActive,
  }) {
    return HomeInitial(
      isVoiceInputActive: isVoiceInputActive ?? this.isVoiceInputActive,
    );
  }

  @override
  List<Object?> get props => [isVoiceInputActive];
}

class HomeLoaded extends HomeState {
  final List<ChatMessage> messages;
  final bool isVoiceInputActive;
  const HomeLoaded(this.messages, {this.isVoiceInputActive = false});
  HomeLoaded copyWith({
    List<ChatMessage>? messages,
    bool? isVoiceInputActive,
  }) {
    return HomeLoaded(
      messages ?? this.messages,
      isVoiceInputActive: isVoiceInputActive ?? this.isVoiceInputActive,
    );
  }

  @override
  List<Object?> get props => [messages, isVoiceInputActive];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object?> get props => [message];
}
