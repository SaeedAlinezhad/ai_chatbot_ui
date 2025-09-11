class SpeechResult {
  final String text;
  final double confidence;
  final double amplitude;

  SpeechResult({
    required this.text,
    required this.confidence,
    required this.amplitude,
  });
}