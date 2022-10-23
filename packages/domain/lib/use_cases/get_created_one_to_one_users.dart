import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetCreatedOneToOneChatsUseCase {
  final IFirestoreRepository repository;

  GetCreatedOneToOneChatsUseCase({required this.repository});
  Stream<List<UserEntity>> call() {
    return repository.getAllChatedUsers();
  }
}
