import 'package:domain/repository/chat_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';
import 'package:domain/entities/engage_user_entity.dart';

class CreateOneToOneChatChannelUseCase
    extends UseCaseParams<EngageUserEntity, Future<String>> {
  final IFirestoreRepository repository;

  CreateOneToOneChatChannelUseCase({required this.repository});
  @override
  Future<String> call(EngageUserEntity params) async {
    return repository.createOneToOneChatChannel(params);
  }

  @override
  void dispose() {}
}
