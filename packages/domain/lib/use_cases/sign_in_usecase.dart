import 'package:domain/entities/user_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class SignInUseCase {
  final IChatRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signIn(user);
  }
}
