import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/user_entity.dart';

class GetAllUsersUseCase {
  final ChatRepository repository;

  GetAllUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getAllUsers();
  }
}
