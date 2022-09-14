import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/user_entity.dart';

class SignUpUseCase {
  final ChatRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
