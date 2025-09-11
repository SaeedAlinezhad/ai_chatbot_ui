part of 'voice_cubit.dart';

class VoiceState extends Equatable {
  final String text;
  final double confidence;
  final double amplitude;
  final bool isListening;

  const VoiceState({
    required this.text,
    required this.confidence,
    required this.amplitude,
    this.isListening = true,
  });

  VoiceState copyWith({
    String? text,
    double? confidence,
    double? amplitude,
    bool? isListening,
  }) {
    return VoiceState(
      text: text ?? this.text,
      confidence: confidence ?? this.confidence,
      amplitude: amplitude ?? this.amplitude,
      isListening: isListening ?? this.isListening,
    );
  }

  @override
  List<Object?> get props => [text, confidence, amplitude, isListening];
}
