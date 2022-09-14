import 'package:data/repository/chat_repository_impl.dart';

class GoogleSignInUseCase {
  final ChatRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<void> call() {
    return repository.googleAuth();
  }
}
