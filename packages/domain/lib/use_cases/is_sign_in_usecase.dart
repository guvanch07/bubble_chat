import 'package:domain/repository/chat_repository.dart';

class IsSignInUseCase {
  final IFirestoreRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
