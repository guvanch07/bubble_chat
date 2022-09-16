import 'package:domain/repository/chat_repository.dart';

class SignOutUseCase {
  final IChatRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
