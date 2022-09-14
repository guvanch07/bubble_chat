import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/use_cases/base_usecase.dart';
import 'package:domain/models/entities/my_chat_entity.dart';

class AddToMyChatUseCase extends UseCaseParams<MyChatEntity, Future<void>> {
  final ChatRepository repository;

  AddToMyChatUseCase({required this.repository});

  @override
  Future<void> call(MyChatEntity params) async {
    return await repository.addToMyChat(params);
  }

  @override
  void dispose() {}
}
