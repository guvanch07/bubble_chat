import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/use_cases/base_usecase.dart';
import 'package:domain/models/entities/my_chat_entity.dart';

class CreateNewGroupUseCase
    extends UseCaseParams<NewGroupParams, Future<void>> {
  final ChatRepository repository;

  CreateNewGroupUseCase({required this.repository});
  @override
  Future<void> call(NewGroupParams params) async {
    return repository.createNewGroup(
        params.myChatEntity, params.selectUserList);
  }

  @override
  void dispose() {}
}

class NewGroupParams {
  final MyChatEntity myChatEntity;
  final List<String> selectUserList;
  const NewGroupParams({
    required this.myChatEntity,
    required this.selectUserList,
  });
}
