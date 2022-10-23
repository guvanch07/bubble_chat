import 'package:domain/repository/base_repository.dart';

abstract class IImageRepository implements BaseRepository {
  Future<void> upload(String inputSource);
  Stream<List<Map<String, dynamic>>> loadImages();
}
