import 'package:domain/entities/group_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class JoinGroupUseCase {
  final IFirestoreRepository repository;

  JoinGroupUseCase({required this.repository});

  Future<void> call(GroupEntity groupEntity) async {
    return await repository.joinGroup(groupEntity);
  }
}
