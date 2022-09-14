import 'package:data/repository/chat_repository_impl.dart';

class IsSignInUseCase {
  final ChatRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
