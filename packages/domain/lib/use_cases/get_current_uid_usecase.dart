import 'package:domain/repository/chat_repository.dart';

class GetCurrentUIDUseCase {
  final IFirestoreRepository repository;

  GetCurrentUIDUseCase({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentUId();
  }
}
