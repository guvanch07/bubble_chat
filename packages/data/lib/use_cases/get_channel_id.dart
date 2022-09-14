import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/engage_user_entity.dart';

class GetChannelIdUseCase {
  final ChatRepository repository;

  GetChannelIdUseCase({required this.repository});

  Future<String> call(EngageUserEntity engageUserEntity) async {
    return repository.getChannelId(engageUserEntity);
  }
}
