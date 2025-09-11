import 'dart:async';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../domain/entities/speech_result.dart';

abstract class SpeechRepository {
  Stream<SpeechResult> listen();
}

class SpeechRepositoryImpl implements SpeechRepository {
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  Stream<SpeechResult> listen() async* {
    bool available = await _speech.initialize();
    if (!available) return;

    final controller = StreamController<SpeechResult>();

    _speech.listen(
      onResult: (val) {
        controller.add(SpeechResult(
          text: val.recognizedWords,
          confidence: val.hasConfidenceRating ? val.confidence : 1.0,
          amplitude: 0.0,
        ));

        if (val.finalResult) {
          controller.close();
        }
      },
      onSoundLevelChange: (level) {
        controller.add(SpeechResult(
          text: '',
          confidence: 1.0,
          amplitude: (level / 100).clamp(0.0, 1.0),
        ));
      },
      partialResults: true,
      listenMode: stt.ListenMode.dictation, 
    );

    yield* controller.stream;
  }
}
