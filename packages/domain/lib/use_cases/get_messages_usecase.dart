import 'package:domain/entities/text_messsage_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetMessageUseCase {
  final IFirestoreRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(bool channel, String channelId) {
    return repository.getMessages(channel, channelId);
  }
}
