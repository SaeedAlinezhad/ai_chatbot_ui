import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orbix_chat/features/voice_input/domain/usecases/listen_to_speech.dart';

part 'voice_state.dart';

class VoiceCubit extends Cubit<VoiceState> {
  final ListenToSpeechUseCase listenUseCase;

  VoiceCubit(this.listenUseCase)
      : super(const VoiceState(text: "Say something...", confidence: 1.0, amplitude: 0.0, isListening: true));

  void startListening() {
    emit(state.copyWith(isListening: true));

    listenUseCase.execute().listen(
      (result) {
        emit(state.copyWith(
          text: result.text.isNotEmpty ? result.text : state.text,
          confidence: result.confidence,
          amplitude: result.amplitude,
        ));
      },
      onDone: () {
        emit(state.copyWith(isListening: false));
      },
      onError: (_) {
        emit(state.copyWith(isListening: false));
      },
    );
  }
}
