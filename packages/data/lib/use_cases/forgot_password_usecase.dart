import 'package:data/repository/chat_repository_impl.dart';
import 'package:data/use_cases/base_usecase.dart';
import 'package:domain/models/entities/group_entity.dart';

class ForgotPasswordUseCase extends UseCaseParams<String, Future<void>> {
  final ChatRepository repository;

  ForgotPasswordUseCase({required this.repository});
  @override
  Future<void> call(String params) async {
    return repository.forgotPassword(params);
  }

  @override
  void dispose() {}
}
