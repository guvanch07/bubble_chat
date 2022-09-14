import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/group_entity.dart';

class JoinGroupUseCase {
  final ChatRepository repository;

  JoinGroupUseCase({required this.repository});

  Future<void> call(GroupEntity groupEntity) async {
    return await repository.joinGroup(groupEntity);
  }
}
