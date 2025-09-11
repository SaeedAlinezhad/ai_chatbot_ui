part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends HomeEvent {
  final String text;
  const SendMessageEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class ClearMessagesEvent extends HomeEvent {}

class ToggleVoiceInputEvent extends HomeEvent {
  final bool voiceState;
  const ToggleVoiceInputEvent(this.voiceState);

  @override
  List<Object?> get props => [voiceState];
}
