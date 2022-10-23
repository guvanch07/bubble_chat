import 'package:domain/entities/text_messsage_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class SendTextMessageUseCase {
  final IFirestoreRepository repository;

  SendTextMessageUseCase({required this.repository});

  Future<void> call(bool channel, TextMessageEntity textMessageEntity,
      String channelId) async {
    return await repository.sendTextMessage(
        channel, textMessageEntity, channelId);
  }
}
