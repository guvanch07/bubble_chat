import 'package:domain/repository/chat_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';

class ForgotPasswordUseCase extends UseCaseParams<String, Future<void>> {
  final IFirestoreRepository repository;

  ForgotPasswordUseCase({required this.repository});
  @override
  Future<void> call(String params) async {
    return repository.forgotPassword(params);
  }

  @override
  void dispose() {}
}
