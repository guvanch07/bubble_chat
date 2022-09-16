import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetCreateCurrentUserUseCase {
  final IChatRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
