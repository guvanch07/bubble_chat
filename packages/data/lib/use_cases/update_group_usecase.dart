import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/group_entity.dart';

class UpdateGroupUseCase {
  final ChatRepository repository;

  UpdateGroupUseCase({required this.repository});
  Future<void> call(GroupEntity groupEntity) {
    return repository.updateGroup(groupEntity);
  }
}
