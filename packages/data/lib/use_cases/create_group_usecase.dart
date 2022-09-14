import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/use_cases/base_usecase.dart';
import 'package:domain/models/entities/group_entity.dart';

class GetCreateGroupUseCase extends UseCaseParams<GroupEntity, Future<void>> {
  final ChatRepository repository;

  GetCreateGroupUseCase({required this.repository});
  @override
  Future<void> call(GroupEntity params) async {
    return await repository.getCreateGroup(params);
  }

  @override
  void dispose() {}
}
