import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class SignUpUseCase {
  final IChatRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signUp(user);
  }
}
