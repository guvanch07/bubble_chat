import 'package:domain/entities/image_params_entity.dart';
import 'package:domain/repository/base_repository.dart';

abstract class IImageRepository implements BaseRepository {
  Future<void> upload(
      {required String inputSource,
      required String uploadBy,
      required String description});
  Stream<List<ImageParms>> loadImages();
}
