import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/text_messsage_entity.dart';

class SendTextMessageUseCase {
  final ChatRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(
      TextMessageEntity textMessageEntity, String channelId) async {
    return await repository.sendTextMessage(textMessageEntity, channelId);
  }
}
