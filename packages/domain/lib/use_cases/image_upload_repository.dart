// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/entities/image_params_entity.dart';
import 'package:domain/repository/image_repository.dart';
import 'package:domain/use_cases/base_usecase.dart';

class LoadImagesUseCase extends UseCase<Stream<List<ImageParms>>> {
  final IImageRepository _repository;

  LoadImagesUseCase(this._repository);

  @override
  Stream<List<ImageParms>> call() => _repository.loadImages();

  @override
  void dispose() {}
}

class UploadImagesUseCase
    extends UseCaseParams<UpLoadImageParams, Future<void>> {
  final IImageRepository _repository;

  UploadImagesUseCase(this._repository);

  @override
  void dispose() {}

  @override
  Future<void> call(UpLoadImageParams params) => _repository.upload(
        description: params.description,
        inputSource: params.source,
        uploadBy: params.uploadBy,
      );
}

class UpLoadImageParams {
  final String uploadBy;
  final String description;
  final String source;
  const UpLoadImageParams({
    required this.uploadBy,
    required this.description,
    required this.source,
  });
}
