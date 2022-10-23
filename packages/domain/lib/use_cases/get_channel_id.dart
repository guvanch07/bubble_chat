import 'package:domain/entities/engage_user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetChannelIdUseCase {
  final IFirestoreRepository repository;

  GetChannelIdUseCase({required this.repository});

  Future<String> call(EngageUserEntity engageUserEntity) async {
    return repository.getChannelId(engageUserEntity);
  }
}
