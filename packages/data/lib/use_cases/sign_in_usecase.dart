import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/user_entity.dart';

class SignInUseCase {
  final ChatRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.signIn(user);
  }
}
