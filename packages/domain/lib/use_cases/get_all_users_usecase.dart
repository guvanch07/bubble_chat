import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetAllUsersUseCase {
  final IChatRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
