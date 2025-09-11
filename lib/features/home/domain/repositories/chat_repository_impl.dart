import 'package:orbix_chat/features/home/data/datasources/chat_remote_datasource.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ChatMessage>> sendMessage(String text) {
    return remoteDataSource.sendMessage(text);
  }

  @override
  Future<void> clearMessages() async {
  }
}
