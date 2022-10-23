import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetUpdateUserUseCase {
  final IFirestoreRepository repository;

  GetUpdateUserUseCase({required this.repository});
  Future<void> call(UserEntity user) {
    return repository.getUpdateUser(user);
  }
}
