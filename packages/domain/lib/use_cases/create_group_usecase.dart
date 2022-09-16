import 'package:domain/repository/chat_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';
import 'package:domain/entities/group_entity.dart';

class GetCreateGroupUseCase extends UseCaseParams<GroupEntity, Future<void>> {
  final IChatRepository repository;

  GetCreateGroupUseCase({required this.repository});
  @override
  Future<void> call(GroupEntity params) async {
    return await repository.getCreateGroup(params);
  }

  @override
  void dispose() {}
}
