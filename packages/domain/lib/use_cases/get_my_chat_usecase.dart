import 'package:domain/entities/my_chat_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetMyChatUseCase {
  final IChatRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<MyChatEntity>> call(String uid) {
    return repository.getMyChat(uid);
  }
}
