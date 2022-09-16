import 'package:domain/entities/group_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class UpdateGroupUseCase {
  final IChatRepository repository;

  UpdateGroupUseCase({required this.repository});
  Future<void> call(GroupEntity groupEntity) {
    return repository.updateGroup(groupEntity);
  }
}
