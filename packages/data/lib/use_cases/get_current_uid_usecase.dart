import 'package:data/repository/chat_repository_impl.dart';

class GetCurrentUIDUseCase {
  final ChatRepository repository;

  GetCurrentUIDUseCase({required this.repository});
  Future<String> call() async {
    return await repository.getCurrentUId();
  }
}
