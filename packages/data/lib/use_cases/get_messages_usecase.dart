import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/text_messsage_entity.dart';

class GetMessageUseCase {
  final ChatRepository repository;

  GetMessageUseCase({required this.repository});

  Stream<List<TextMessageEntity>> call(String channelId) {
    return repository.getMessages(channelId);
  }
}
