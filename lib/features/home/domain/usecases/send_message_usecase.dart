import '../entities/chat_message.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;
  SendMessageUseCase(this.repository);

  Future<List<ChatMessage>> call(String text) async {
    return await repository.sendMessage(text);
  }
}
