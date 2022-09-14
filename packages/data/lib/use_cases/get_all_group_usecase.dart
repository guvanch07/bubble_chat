import 'package:data/repository/chat_repository_impl.dart';
import 'package:domain/models/entities/group_entity.dart';

class GetAllGroupsUseCase {
  final ChatRepository repository;

  GetAllGroupsUseCase({required this.repository});

  Stream<List<GroupEntity>> call() {
    return repository.getGroups();
  }
}
