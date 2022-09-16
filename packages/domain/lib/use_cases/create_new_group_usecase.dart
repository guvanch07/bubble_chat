import 'package:domain/entities/my_chat_entity.dart';
import 'package:domain/repository/chat_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';

class CreateNewGroupUseCase
    extends UseCaseParams<NewGroupParams, Future<void>> {
  final IChatRepository repository;

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
