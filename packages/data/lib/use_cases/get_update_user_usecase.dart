import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/user_entity.dart';

class GetUpdateUserUseCase {
  final ChatRepository repository;

  GetUpdateUserUseCase({required this.repository});
  Future<void> call(UserEntity user) {
    return repository.getUpdateUser(user);
  }
}
