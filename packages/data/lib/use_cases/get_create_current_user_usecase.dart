import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/user_entity.dart';

class GetCreateCurrentUserUseCase {
  final ChatRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
