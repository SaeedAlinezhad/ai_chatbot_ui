
import 'package:orbix_chat/features/voice_input/data/repositories/speech_repository.dart';
import 'package:orbix_chat/features/voice_input/domain/entities/speech_result.dart';

class ListenToSpeechUseCase {
  final SpeechRepository repository;

  ListenToSpeechUseCase(this.repository);

  Stream<SpeechResult> execute() {
    return repository.listen();
  }
}
