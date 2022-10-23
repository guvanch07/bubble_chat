import 'package:domain/repository/chat_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';
import 'package:domain/entities/my_chat_entity.dart';

class AddToMyChatUseCase extends UseCaseParams<MyChatEntity, Future<void>> {
  final IFirestoreRepository repository;

  AddToMyChatUseCase({required this.repository});

  @override
  Future<void> call(MyChatEntity params) async {
    return await repository.addToMyChat(params);
  }

  @override
  void dispose() {}
}
