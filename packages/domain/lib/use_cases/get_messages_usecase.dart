import 'package:domain/entities/text_messsage_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetMessageUseCase {
  final IChatRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
