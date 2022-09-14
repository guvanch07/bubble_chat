import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/use_cases/base_usecase.dart';
import 'package:domain/models/entities/engage_user_entity.dart';
import 'package:domain/models/entities/group_entity.dart';

class CreateOneToOneChatChannelUseCase
    extends UseCaseParams<EngageUserEntity, Future<String>> {
  final ChatRepository repository;

  CreateOneToOneChatChannelUseCase({required this.repository});
  @override
  Future<String> call(EngageUserEntity params) async {
    return repository.createOneToOneChatChannel(params);
  }

  @override
  void dispose() {}
}
