import 'package:data/repository/chat_repository_impl.dart';

class SignOutUseCase {
  final ChatRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
