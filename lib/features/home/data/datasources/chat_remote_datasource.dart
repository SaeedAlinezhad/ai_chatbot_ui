import '../../domain/entities/chat_message.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatMessage>> sendMessage(String text);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl();

  @override
  Future<List<ChatMessage>> sendMessage(String text) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ChatMessage(text: text, isUser: true),
      ChatMessage(text: "Response to '$text'", isUser: false),
    ];
  }
}
