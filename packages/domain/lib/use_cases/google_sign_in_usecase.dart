import 'package:domain/repository/chat_repository.dart';

class GoogleSignInUseCase {
  final IChatRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<void> call() {
    return repository.googleAuth();
  }
}
