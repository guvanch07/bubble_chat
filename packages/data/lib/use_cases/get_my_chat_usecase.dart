import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/my_chat_entity.dart';

class GetMyChatUseCase {
  final ChatRepository repository;

  GetMyChatUseCase({required this.repository});

  Stream<List<MyChatEntity>> call(String uid) {
    return repository.getMyChat(uid);
  }
}
