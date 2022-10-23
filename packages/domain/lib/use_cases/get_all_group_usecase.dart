import 'package:domain/entities/group_entity.dart';
import 'package:domain/repository/chat_repository.dart';

class GetAllGroupsUseCase {
  final IFirestoreRepository repository;

  GetAllGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call() {
    return repository.getGroups();
  }
}
